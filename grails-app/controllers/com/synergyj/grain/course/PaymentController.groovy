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

import grails.converters.JSON

class PaymentController {

  def springSecurityService
  def paymentService
  def notificationService
  def registrationService
  def receiptService

  def index = {
    // Obtenemos el usuario actual
    def user = springSecurityService.currentUser
    // Obtenemos sus cursos pendientes por pagar
    // Buscamos el registro del usuario a un curso calendarizado y Metemos el objeto registration en sesión
    def registration = Registration.findByStudentAndRegistrationStatus(user, RegistrationStatus.REGISTERED)
    // Eliminamos las promociones asociadas a este registro si es que tiene
    if (registration?.promotions?.size()) {
      registration.promotions.each { r ->
        registration.removeFromPromotions(r)
      }
    }
    //Obtenemos las promociones de este curso calendarizado
    def promotionsPerCourse = PromotionPerScheduledCourse.findAllByScheduledCourse(registration.scheduledCourse)
    // Obtenemos las promociones que aún estén vigentes
    def promotionsForThisUser = []
    promotionsPerCourse.each { promotion ->
      if (promotion.hasNotExpired())
        promotionsForThisUser << promotion
    }
    session.promotionsPerCourse = promotionsForThisUser
    // Regresamos sus cursos para presentar el detalle y las promociones a escoger
    [registration: registration, promotionsPerCourse: promotionsForThisUser]
  }

  def fileupload = {
    receiptService.attachReceiptToPayment(params.long('paymentNumber'),params.file)
    render "${g.message(code: 'receipt.received')}"
  }

  def start = {
    def payment = Payment.get(params.id)
    [payment: payment]
  }

  def pay = {
    // Conservamos la opción de pago que selecciono
    def paymentOption = KindOfPayment.SPEI
    if (params.paymentOption == 'dineromail') {
      // Pagará con DM
      paymentOption = KindOfPayment.DINERO_MAIL
    }
    def payment = Payment.findByTransactionId(params.transactionId)
    payment.kindOfPayment = paymentOption
    // Validar si es SPEI o DineroMail y direccionarlo
    if (paymentOption == KindOfPayment.SPEI) {
      notificationService.sendPaymentInstructions(payment.id)
      flash.message = "${g.message(code: 'notification.send')}"
      redirect action: 'receive', params: [status: 'pending', trx: payment.transactionId]
      return
    } else {
      render view: "do", model: [registration: payment.registration, payment: payment, user: springSecurityService.currentUser]
    }
  }

  def receive = {
    // Si obtenemos algún error de pago
    if (params.status == 'error') {
      // Ponemos un mensaje
      flash.message = "${g.message(code: 'payment.error')}"
      // Redireccionamos
      redirect uri: '/me'
      return
    }
    // Si traemos algún parámetro de pago
    if (params.status && params.trx) {
      // Actualizamos el pago y el registro
      def payment = paymentService.checkPaymentAndRegistration(params.status, params.trx)
      // Evaluamos el pago para mandar el mensaje apropiado
      switch (payment.kindOfPayment) {
        case KindOfPayment.SPEI:
          flash.message = "${g.message(code: 'payment.waitSpei')}"
          break
        case KindOfPayment.DINERO_MAIL:
          switch (payment.paymentStatus) {
            case PaymentStatus.PENDING:
              flash.message = "${g.message(code: 'payment.waitPending')}"
              break
            case PaymentStatus.PAYED:
              // Comprobamos si el registro al curso ya esta pagado
              registrationService.checkIsPayed(payment.registration.id)
              flash.message = "${g.message(code: 'payment.ispayed')}"
              break;
          }
          break
      }
    }
    redirect uri: '/me'
  }

  def create = {

    // Conservamos la opción de pago que selecciono
    def paymentOption = "spei"
    if (params.paymentOption == "dineromail") {
      // Pagará con DM
      paymentOption = "dineroMail"
    }

    // Creamos los pagos para el registro
    def registration = new Registration()
    try {
      registration = paymentService.preparePaymentsForRegistration(
        params.long("registrationId"),
        new BigDecimal(params.totalToPay),
        new BigDecimal(params.percentOption),
        paymentOption,
        params.invoice)
    } catch (Exception e) {
      flash.message = message(code: "payment.already.generated")
      redirect(controller: 'user',action: 'me')
    }

    // Obtenemos las promociones que selecciono/aplico, vienen en un string separado por comas
    def promotionsIds = params?.checkedPromotions?.tokenize(',')

    // Iteramos la seleccion de promociones
    promotionsIds.each { promotionId ->
      // buscamos en la lista de promociones en la sesion el descuento
      def promotionPerCourse = (session.promotionsPerCourse).find { it.id >= promotionId.toLong() }
      // Generamos el objeto de promoción por registro
      def promotionPerRegistration = new PromotionPerRegistration(
          promotion: promotionPerCourse.promotion,
          registration: registration
      )
      // Si escogió la recomendación
      if (promotionPerRegistration.promotion.kindPromotion == KindPromotion.RECOMMENDATION) {
        // Creamos el objeto para tomar el valor, en este caso el correo
        def promotionPerRegistrationProperty = new PromotionPerRegistrationProperty()
        promotionPerRegistrationProperty.propertyKey = "email"
        promotionPerRegistrationProperty.propertyValue = params."emailFrom${promotionId}"
        // Agregamos la propiedad a la promoción
        promotionPerRegistration.addToPromotionPerRegistrationProperties(promotionPerRegistrationProperty)
      }
      // Agregamos la promoción que aplicó al registro
      registration.addToPromotions(promotionPerRegistration)
    }

    // Eliminamos los valores de la sesión
    if (session?.promotionsPerCourse)
      session.removeAttribute("promotionsPerCourse")

    // Consultamos los pagos para el registro para mandarlos por el modelo
    def payment = Payment.findByRegistrationAndPaymentStatus(registration, PaymentStatus.WAITING, [sort: 'id'])

    // Validar si es SPEI o DineroMail y direccionarlo
    if (paymentOption == 'spei') {
      notificationService.sendPaymentInstructions(payment.id)
      flash.message = "${g.message(code: 'notification.send')}"
      redirect action: 'receive', params: [status: 'pending', trx: payment.transactionId]
      return
    } else {
      render view: "do", model: [registration: registration, payment: payment, user: springSecurityService.currentUser]
    }

  }

  def edit = {
    def payment = Payment.get(params.id)
    [payment: payment]
  }

  def updateAsync = {
    def payment = Payment.get(params.id)
    payment.properties = params
    if (payment.save()) {
      flash.message = "${message(code: 'default.updated.message', args: [payment.class.name, payment.id])}"
    } else {
      flash.message = "${message(code: 'default.optimistic.locking.failure', args: [payment.class.name, payment.id])}"
    }
    render flash.message
  }

  def delete = {
    def payment = Payment.get(params.id)
    payment.delete()
    flash.message = "${message(code: 'default.deleted.message', args: [payment.class.name, payment.id])}"
    redirect uri: '/me'
  }

  def createForRegistration = {
    //def registration = Registration.get(params.id)
    def paymentOption = "spei"
    if (params.paymentOption == "DINERO_MAIL") {
      // Pagará con DM
      paymentOption = "dineromail"
    }
    def totalToPay = new BigDecimal(params.costByCourse)
    if (params.invoice)
      totalToPay = totalToPay * 1.16

    def thisPayment = totalToPay / (new BigDecimal(params.percentOption))

    // Creamos los pagos para el registro
    paymentService.preparePaymentsForRegistration(
        params.long("registrationId"),
        totalToPay,
        thisPayment,
        paymentOption,
        params.invoice)

    render """
      <img src="${resource(dir: 'themes/wb/icon', file: 'valid-green.png')}" width="24" height="24" />
    """
  }

  def showForRegistrationAsync = {
    // Obtenemos el registration
    def registration = Registration.get(params.id)
    // Desplegamos el template con los datos de los pagos del registro
    render template: "/payment/showForRegistration",model:[registration:registration]
  }

  def showForEditAsync = {
    def payment = Payment.get(params.id)
    render template: "/payment/form",model:[payment:payment]
  }

  def createAsync = {
    def payment = paymentService.addPaymentToRegistration(params.long('id'))
    render payment as JSON
  }

}
