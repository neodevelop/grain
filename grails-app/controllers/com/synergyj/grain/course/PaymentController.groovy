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
    if(!session.registration){
      // Buscamos el registro del usuario a un curso calendarizado y Metemos el objeto registration en sesión
      session.registration  = Registration.findByStudentAndRegistrationStatus(user,RegistrationStatus.REGISTERED)
    }
    //Obtenemos las promociones de este curso calendarizado
    if(!session.promotionsPerCourse){
      def promotionsPerCourse = PromotionPerScheduledCourse.findAllByScheduledCourse(session.registration.scheduledCourse)
      // Obtenemos las promociones que aún estén vigentes
      def promotionsForThisUser = []
      promotionsPerCourse.each { promotion ->
        if(promotion.hasNotExpired())
          promotionsForThisUser << promotion
      }
      session.promotionsPerCourse = promotionsForThisUser
    }
    session.finalAmountWithTax = session.registration.scheduledCourse.costByCourse
    // TODO: Recuerda quitar estos de sesión "promotionsPerCourse" "registration" "choosedPromotions" "finalAmountWithTax"
    // Regresamos sus cursos para presentar el detalle y las promociones a escoger
    [registration:session.registration,promotionsPerCourse:session.promotionsPerCourse]
  }

  def recalculate = {
    def model = [:]
    def scheduledCourse = session.registration.scheduledCourse
    // Creamos una lista para las promociones que aplican o escogió
    session.choosedPromotions = []
    // Obtenemos los descuentos y recalculamos el precio
    if(params.discount){
      model.discount = 0
      // Aplicamos los descuentos de las promociones
      params.discount.each{ discountId ->
        // buscamos en la lista de promociones en la sesion el descuento
        def promotionPerCourse = (session.promotionsPerCourse).find { it.id >= Long.valueOf(discountId) }
        //Agregamos la promoción a la lista
        session.choosedPromotions << promotionPerCourse
        // Sumamos los descuentos
        model.discount += (scheduledCourse.costByCourse * (promotionPerCourse.promotion.discount/100))
      }
    }

    model.finalAmount = scheduledCourse.costByCourse - model.discount

    // Si necesita factura le agregamos el IVA
    if(params.invoice){
      // El IVA unicamente para mostrarlo
      model.iva = (scheduledCourse.costByCourse-model.discount) * 0.16
      // El precio más IVA
      model.finalAmountWithTax = model.finalAmount * 1.16
      // Indicamos que si necesitará factura
      session.invoice = true
    }else{
      model.iva = 0
      model.finalAmountWithTax = model.finalAmount
      session.removeAttribute("invoice")
    }
    // Agregamos el monto final
    session.finalAmountWithTax = model.finalAmountWithTax
    // Agregamos el registro a la sesión
    model.registration = session.registration
    render template: '/registration/simpleShow',model:model
  }

  def resetPromotions = {
    render(template:'/promotion/showForPayment',model:[promotionsPerCourse:session.promotionsPerCourse,resetPromotions:true])
  }

  def confirm = {
    println params.dump()
    // Poner en sesion el correo de la recomendacion si existe
    // Poner en sesion las promociones que escogío
    // Crear el modelo con el numero de pagos a realizar y la cantidad total
    def payments = []
    def paymentsNumber = Integer.valueOf(params.paymentNumber)
    switch(paymentsNumber){
      case 1:
        payments << new Payment(
            amount: Double.valueOf(params.finalAmount),paymentStatus: PaymentStatus.REGISTERED
        )
        break
      case 2:
        payments << new Payment(
            amount: Double.valueOf(params.finalAmount)/2,paymentStatus: PaymentStatus.REGISTERED
        )
        payments *= 2
        break
    }
    def model = [payments:payments]
    render template: "confirm",model:model
  }
}
