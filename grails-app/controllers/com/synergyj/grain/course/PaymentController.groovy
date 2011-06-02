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
    def registration = Registration.findByStudentAndRegistrationStatus(user,RegistrationStatus.REGISTERED)
    //Obtenemos las promociones de este curso calendarizado
    def promotionsPerCourse = PromotionPerScheduledCourse.findAllByScheduledCourse(registration.scheduledCourse)
    // Regresamos sus cursos para presentar el detalle y las promociones a escoger
    [registration:registration,promotionsPerCourse:promotionsPerCourse]
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
