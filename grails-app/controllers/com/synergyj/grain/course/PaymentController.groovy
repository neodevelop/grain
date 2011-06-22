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

class PaymentController {

  def springSecurityService

  def index = {
    // Obtenemos el usuario actual
    def user = springSecurityService.currentUser
    // Obtenemos sus cursos pendientes por pagar
    // Buscamos el registro del usuario a un curso calendarizado y Metemos el objeto registration en sesión
    def registration  = Registration.findByStudentAndRegistrationStatus(user,RegistrationStatus.REGISTERED)

    //Obtenemos las promociones de este curso calendarizado
    def promotionsPerCourse = PromotionPerScheduledCourse.findAllByScheduledCourse(session.registration.scheduledCourse)
    // Obtenemos las promociones que aún estén vigentes
    def promotionsForThisUser = []
    promotionsPerCourse.each { promotion ->
      if(promotion.hasNotExpired())
        promotionsForThisUser << promotion
    }
    // Regresamos sus cursos para presentar el detalle y las promociones a escoger
    [registration:registration,promotionsPerCourse:promotionsForThisUser]
  }

  def create = {
    println params
    println session
    // Actualizamos el objeto registration
    def registration = Registration.get(session.registration.id)
    // Necesitará factura?
    if(session?.invoice)
      registration.invoice = session.invoice
    // Agregamos las promociones que escogió para su registro
    session?.choosedPromotions?.each{ promotionPerRegistration ->
      // Si la promoción tiene alguna propiedad(el correo de la recomnedación)
      if(promotionPerRegistration.promotionPerRegistrationProperties){
        // Iteramos para agregarlas
        promotionPerRegistration.promotionPerRegistrationProperties.each{ promotionProperty ->
          // Las agregamos...
          //promotionPerRegistration.addToPromotionPerRegistrationProperties(promotionProperty)
        }
      }
      //registration.addToPromotions(promotionPerRegistration)
    }
    // Evaluamos si escogio el pago completo o dos pagos
    def currentPayment
    switch(params.int("percentOption")){
      case 1:
        def payment = preparePayment(session.finalAmountWithTax)
        currentPayment = payment
        //registration.addToPayments(payment)
        break;
      case 2:
        def payment1 = preparePayment(session.finalAmountWithTax/2)
        def payment2 = preparePayment(session.finalAmountWithTax/2)
        currentPayment = payment1
        //registration.addToPayments(payment1)
        //registration.addToPayments(payment2)
        break;
    }
    def template = "spei"
    if(params.paymentOption == 'dineromail'){
      // Si se paga con DM entonces aqui agregamos el payment al model
      template = "dineroMail"
    }
    // TODO: Recuerda quitar estos de sesión "promotionsPerCourse" "registration" "choosedPromotions" "finalAmountWithTax"
    render template:template,model:[registration:registration,payment:currentPayment]
  }

  def preparePayment(amount){
    return new Payment(
      amount:amount,
      transactionId:UUID.randomUUID().toString().replaceAll('-', '').substring(0,20),
      paymentStatus:PaymentStatus.REGISTERED
    )
  }
}
