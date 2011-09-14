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

import grails.plugins.springsecurity.Secured
import com.synergyj.grain.auth.RegisterUserCommand
import grails.converters.JSON
import com.synergyj.grain.auth.RegistrationCodeForScheduledCourse

class LandingController {

  def userService
  def notificationService
  def scheduledCourseService

  @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
  def addMeNoPost = {
    // Recibimos el email y el id de curso calendarizado
    // Llamamos el método privado que genera la URL
    def actionAndRegistrationCode = obtainRegistrationCode(params.email,params.long("scheduledCourseId"))

    redirect(uri: "/${actionAndRegistrationCode.myAction}?code=${actionAndRegistrationCode.registrationCode.token}")
  }

  @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
  def addMe = { RegisterUserCommand registerUserCommand ->
    // Determinamos si en este curso se puede inscribir
    response.addHeader("Access-Control-Allow-Origin","*")
    response.addHeader("Content-Type","	application/json;charset=UTF-8")
    // Recibimos el email y el id de curso calendarizado
    // Llamamos el método privado que genera la URL
    def actionAndRegistrationCode = obtainRegistrationCode(params.email,params.long("scheduledCourseId"))
    // Checamos si el curso está disponible
    if(scheduledCourseService.isAvailableToRegister(params.long("scheduledCourseId"))){
      // Formamos la URL con el resultado
      def url = request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath+'/'
      url += actionAndRegistrationCode.myAction+"?code="+actionAndRegistrationCode.registrationCode.token
      // Regresamos una respuesta para el formulario de registro
      render([url:url] as JSON)
    }else{
      // Mensaje de no disponibilidad
      render([message:message(code:'scheduledCourse.not.available')] as JSON)
    }

  }

  @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
  def create = {
  }

  private def obtainRegistrationCode(String email, Long scheduledCourseId){
    // Buscamos si el usuario ya se registró previamente
    def registrationCode = RegistrationCodeForScheduledCourse.findByUsernameAndScheduledCourseId(email,scheduledCourseId)

    // Si no existe un código de registro lo generamos
    if(!registrationCode){
      registrationCode = RegistrationCodeForScheduledCourse.create(email,scheduledCourseId)
    }

    // Buscamos el usuario por su correo
    def user = userService.findUser(email)
    def myAction = ""
    if(user){
      // Si ya existe el usuario entonces lo notificamos
      notificationService.sendConfirmRegistration(user,scheduledCourseId,registrationCode)
      // Definimos la acción
      myAction = "confirmRegistration"
    }else{
      // Si no existe entonces lo invitamos
      registrationCode = notificationService.sendInvitation(email,scheduledCourseId,registrationCode)
      // Definimos la acción
      myAction = "signup"
    }
    [myAction:myAction,registrationCode:registrationCode]
  }
}
