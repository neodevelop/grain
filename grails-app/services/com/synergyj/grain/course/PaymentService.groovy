/*
 * Copyright 2002-2008 the original author or authors.
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
package com.synergyj.grain.course

class PaymentService {
  static transactional = true

  def checkPaymentAndRegistration(String status, String transactionId){
    // Buscamos el payment
    def payment = Payment.findByTransactionId(transactionId)
    // Actualizamos el status del payment según el parámetro
    switch(status){
      case 'pending':
        // Cambiamos el status del payment
        payment.paymentStatus = PaymentStatus.PENDING
        // El registro al curso aún no se paga aunque este sea el último pago, aún está pendiente de pago
        payment.registration.registrationStatus = RegistrationStatus.PENDING_PAYMENT
        break
      case 'payed':
        // Cambiamos el status del payment
        payment.paymentStatus = PaymentStatus.PAYED
        break
      case 'error':
        break
    }
    payment
  }

  def preparePaymentsForRegistration(
      Long registrationId,
      BigDecimal totalPayment,
      BigDecimal thisPayment,
      String kindOfPayment,
      def withInvoice){

    // Obtenemos el registro que vamos a modificar
    def registration = Registration.get(registrationId)

    // Preparar el pago
    def payment = preparePayment(thisPayment,kindOfPayment)
    // Agregamos el pago al registro
    registration.addToPayments(payment)
    def diff = totalPayment - thisPayment
    if(diff){
      def anotherPayment = preparePayment(diff,"Pendiente por anticipo")
      // Agregamos el pago de la diferencia al registro
      registration.addToPayments(anotherPayment)
    }

    // Cambiamos el estado del registro
    registration.registrationStatus = RegistrationStatus.PENDING_PAYMENT

    // Necesitará factura?
    if(withInvoice)
      registration.invoice = withInvoice

    registration
  }

  private def preparePayment(amount,kindOfPayment){
    def description = "Pago de inscripción"
    def thisKindOfPayment = KindOfPayment.SPEI
    if(kindOfPayment == 'dineromail')
      thisKindOfPayment = KindOfPayment.DINERO_MAIL
    return new Payment(
      amount:amount,
      transactionId:UUID.randomUUID().toString().replaceAll('-', '').substring(0,20),
      paymentStatus:PaymentStatus.WAITING,
      description:description,
      kindOfPayment: thisKindOfPayment,
      commission: 0.0
    )
  }
}
