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
import com.synergyj.grain.course.Payment

class DineroMailService {

  static transactional = true

  static urlIPN = 'https://mexico.dineromail.com/Vender/Consulta_IPN.asp'
  static ipnPassword = '1234abcd.'
  static accountNumber = '580433'
  static timeoutDM = 1000 * 60 * 5

  def verifyPayment(Long paymentId) {
    // Obtenemos el pago que vamos a consultar
    def payment = Payment.get(paymentId)
    // Generamos el cuerpo de la petición con el id de TX
    def requestData = prepareXml(payment.transactionId)
    // Creamos un objeto HTTPBuilder con la url de DM - IPN
    def http = new HTTPBuilder(urlIPN)
    // Ejecutamos la petición con el documento
    http.request(GET, XML) { req ->
      req.getParams().setParameter("http.connection.timeout", new Integer(timeoutDM))
      req.getParams().setParameter("http.socket.timeout", new Integer(timeoutDM))
      // DM solicita que el XML sea enviado en el parámetro DATA
      uri.query = [DATA: requestData]

      // Manejamos la respuesta satisfactoria
      response.success = {resp, data ->
        result = handleResponse(resp, data)
      }

      // Manejamos la respuesta en errores
      response.failure = { resp ->
        //result = "Unexpected error: ${resp.statusLine.statusCode} : ${resp.statusLine.reasonPhrase}"
        //throw new RuntimeException(result)
      }
    }
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

  def handleResponse(resp, data) {
    def result = ''
    def transactionsResult = [:]
    def response = verifyStatus(data.ESTADOREPORTE)
    def status = response.status
    if (status == '1') {
      data.DETALLE.OPERACIONES.OPERACION.each {operation ->
        def idTx = operation.ID.text()
        def statusOperacion = convertStatus(operation.ESTADO.text())
        transactionsResult.put(idTx, statusOperacion)
      }
      //Corroborar los pagos

    } else {
      if ((status == '6' || status == '8')) {
        result = "No operation Found with TransactionId: '${purchase.transactionReference}' in DineroMail. Deleted from the system."
      } else {
        result = response.message
      }
    }
    result
  }

  def verifyStatus(status) {
    def error = [:]
    def message
    switch (status) {
      case '1':
        message = 'Good¡'
        break
      case '2':
        message = 'malformed xml'
        break
      case '3':
        message = "Invalid account number, please verify the configuration for '${accountNumber}'"
        break
      case '4':
        message = "invalid password, please verify the configuration for '${accountNumber}'"
        break
      case '5':
        message = 'invalid query'
        break
      case '6':
        message = 'invalid operation id'
        break
      case '7':
        message = "invalid account number or invalid password, please verify the configuration for '${accountNumber}'"
        break
      case '8':
        message = 'no operations found'
        break
      default:
        message = 'unknow response'
    }
    error.status = status
    error.message = message
    error
  }

  def convertStatus(status) {
    def result
    switch (status) {
      case '1':
        result = PENDING
        break
      case '2':
        result = PAID
        break
      case '3':
        result = CANCELLED
        break
      default:
        result = FLAGGED
    }
    result
  }

}