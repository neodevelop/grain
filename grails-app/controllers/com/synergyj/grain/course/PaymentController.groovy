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
  def paymentService

  def index = {
    // Obtenemos el usuario actual
    def user = springSecurityService.currentUser
    // Obtenemos sus cursos pendientes por pagar
    // Buscamos el registro del usuario a un curso calendarizado y Metemos el objeto registration en sesión
    def registration  = Registration.findByStudentAndRegistrationStatus(user,RegistrationStatus.REGISTERED)

    //Obtenemos las promociones de este curso calendarizado
    def promotionsPerCourse = PromotionPerScheduledCourse.findAllByScheduledCourse(registration.scheduledCourse)
    // Obtenemos las promociones que aún estén vigentes
    def promotionsForThisUser = []
    promotionsPerCourse.each { promotion ->
      if(promotion.hasNotExpired())
        promotionsForThisUser << promotion
    }
    session.promotionsPerCourse = promotionsForThisUser
    // Regresamos sus cursos para presentar el detalle y las promociones a escoger
    [registration:registration,promotionsPerCourse:promotionsForThisUser]
  }

  def create = {

    // Conservamos la opción de pago que selecciono
    def paymentOption = "spei"
    if(params.paymentOption == 'dineromail'){
      // Pagará con DM
      paymentOption = "dineroMail"
    }

    // Creamos los pagos para el registro
    def registration = paymentService.preparePaymentsForRegistration(
        params.long("registrationId"),
        new BigDecimal(params.totalToPay),
        new BigDecimal(params.percentOption),
        paymentOption,
        params.invoice)

    // Obtenemos las promociones que selecciono/aplico, vienen en un string separado por comas
    def promotionsIds = params?.checkedPromotions?.tokenize(',')

    // Iteramos la seleccion de promociones
    promotionsIds.each{ promotionId ->
      // buscamos en la lista de promociones en la sesion el descuento
      def promotionPerCourse = (session.promotionsPerCourse).find { it.id >= promotionId.toLong() }
      // Generamos el objeto de promoción por registro
      def promotionPerRegistration = new PromotionPerRegistration(
        promotion:promotionPerCourse.promotion,
        registration:registration
      )
      // Si escogió la recomendación
      if(promotionPerRegistration.promotion.kindPromotion == KindPromotion.RECOMMENDATION){
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
    if(session.removeAttribute)
      session.removeAttribute(promotionsPerCourse)

    // Consultamos los pagos para el registro para mandarlos por el modelo
    def payment = Payment.findByRegistrationAndPaymentStatus(registration,PaymentStatus.WAITING,[sort:'id'])

    render view:"do",model:[registration:registration,payment:payment,user:springSecurityService.currentUser]
  }


}
