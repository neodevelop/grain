/*
 * Copyright 2002-2010 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.synergyj.grain.event

import groovy.xml.MarkupBuilder
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.ContentType.XML
import static groovyx.net.http.Method.GET
import static groovyx.net.http.Method.POST
import com.synergyj.grain.course.Payment
import java.text.SimpleDateFormat
import com.synergyj.grain.course.PaymentStatus

class DineroMailService {

  static transactional = true

  static urlIPN = "https://mexico.dineromail.com/Vender/Consulta_IPN.asp"
  static ipnPassword = ''
  static accountNumber = ''
  static timeoutDM = 1000 * 60 * 5
  static messageCodes = [
      '0': 'Código invalido',
      '1': "Correcto",
      '2': "XML mal formado",
      '3': "Número de cuenta ${accountNumber} inválido",
      '4': "Clave inválida ${ipnPassword}",
      '5': "Tipo de consulta inválido",
      '6': "ID de operación inválido",
      '7': "Número d cuenta o clave inválido",
      '8': "No se encontraron operaciones a reportar"
  ]
  static statusOperation = [
      '0': 'FLAGGED',
      '1': 'PENDING',
      '2': 'PAID',
      '3': 'CANCELLED'
  ]
  static paymentMethods = [
      '1': 'Fondos DineroMail',
      '2': 'Efectivo en Banco',
      '3': 'Tarjeta de crédito',
      '4': 'Transaferencia bancaria',
      '5': 'Efectivo en Oxxo y 7Eleven',
      '0': 'No categorizado'
  ]

  def verifyPayment(Long paymentId = 0L, String txId = '0') {
    def isPayed = false
    // Si traemos un ID en el payment ID
    def payment
    if (paymentId) {
      // Obtenemos el pago que vamos a consultar por su id de BD
      payment = Payment.get(paymentId)
    } else {
      // Obtenemos el pago que vamos a consultar por su id de TX
      payment = Payment.findByTransactionId(txId)
    }
    // Generamos el cuerpo de la petición con el id de TX
    def requestData = prepareXml(payment.transactionId)
    // Creamos un objeto HTTPBuilder con la url de DM - IPN
    def http = new HTTPBuilder(urlIPN)
    // Ejecutamos la petición con el documento
    http.request(POST, XML) { req ->
      req.getParams().setParameter("http.connection.timeout", new Integer(timeoutDM))
      req.getParams().setParameter("http.socket.timeout", new Integer(timeoutDM))
      // DM solicita que el XML sea enviado en el parámetro DATA
      uri.query = [DATA: requestData]

      // Manejamos la respuesta satisfactoria
      response.success = {resp, data ->
        isPayed = handleResponse(resp, data, payment)
      }

      // Manejamos la respuesta en errores
      response.failure = { resp ->
        log.error("Error en la petición para la tx:${payment.transactionId} ")
        throw new RuntimeException("Unexpected error: ${resp.statusLine.statusCode} : ${resp.statusLine.reasonPhrase}")
      }
    }
    isPayed
  }

  def prepareXml(String txId) {
    def writer = new StringWriter()
    def requestData = new MarkupBuilder(writer)
    requestData.REPORTE {
      NROCTA(accountNumber)
      DETALLE {
        CONSULTA {
          CLAVE(ipnPassword)
          TIPO('1')
          OPERACIONES {
            ID(txId)
          }
        }
      }
    }
    writer.toString()
  }

  private def handleResponse(resp, data, Payment payment) {
    def thisPaymentIsPayed = false
    // Sacamos el estado del reporte
    def statusReport = data.ESTADOREPORTE
    // Obtenemos el mensaje según el código
    def response = messageCodes."${statusReport ?: '0'}"
    // Si el reporte es correcto
    if (statusReport == '1') {
      // Creamos la lista de operaciones realizadas para la TX's
      def operationsForTransaction = []
      // Iteramos las operaciones obtenidas de esta transacción
      data.DETALLE.OPERACIONES.OPERACION.each {operation ->
        def tx = new Expando()
        // Obtenemos el ID de la TX"
        tx.id = operation.ID?.text()
        // Obtenemos el status"
        tx.statusOperation = statusOperation["${operation.ESTADO?.text() ?: '0'}"]
        // Obtenemos la fecha y parseamos ${operation.FECHA}"
        def sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss aa")
        def fecha = operation.FECHA?.text() - '.'
        tx.operationDate = sdf.parse(fecha.toUpperCase())
        // Obtenemos el monto"
        tx.amount = new BigDecimal(operation.MONTO?.text()?.replace(',','.')))
        // Obtenemos el monto total $operation.MONTONETO"
        tx.totalAmount = new BigDecimal(operation.MONTONETO?.text()?.replace(',','.'))
        // Obtenemos el método de pago"
        tx.paymentMethod = paymentMethods["${operation.METODOPAGO?.text() ?: '0'}"]
        operationsForTransaction << tx
      }
      // Buscamos si entre las operaciones existe el pago
      def operationPayed = operationsForTransaction.find { operation ->
        operation.statusOperation == statusOperation['2']
      }
      // Si la operación esta pagada
      if (operationPayed) {
        // Asignamos los valores del pago proveidos por DM a nuestro pago
        payment.paymentDate = operationPayed.operationDate
        payment.commission = operationPayed.amount - operationPayed.totalAmount
        payment.paymentStatus = PaymentStatus.PAYED
        payment.description += " / ${operationPayed.paymentMethod}"
        thisPaymentIsPayed = true
      }
    } else {
      //Si no es correcto entonces lanzamos la excepción
      response += " / Trx ID: ${payment.transactionId}"
      throw new RuntimeException(response)
    }
    thisPaymentIsPayed
  }


}