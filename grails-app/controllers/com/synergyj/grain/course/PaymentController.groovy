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
    def registrations = Registration.findAllByStudentAndRegistrationStatus(user,RegistrationStatus.REGISTERED)
    //Obtenemos las promociones de este curso calendarizado
    // Regresamos sus cursos para presentar el detalle y las promociones a escoger
  }
}
