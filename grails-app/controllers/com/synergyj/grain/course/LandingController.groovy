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

  def scheduledCourseService
  def landingService
  def notificationService
  def userService

  @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
  def addMeNoPost = {
    // Generamos el código de registro o lo obtenemos si ya existe
    def registrationCode = landingService.obtainRegistrationCode(params.email,params.long("scheduledCourseId"))
    // Determinamos la acción a seguir si el usuario es nuevo o no
    def action = actionForANewOrExistingUser(params.email,params.long("scheduledCourseId"),registrationCode)
    // Redireccionamos
    redirect(uri: "/${action}?code=${registrationCode.token}")
  }

  @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
  def addMe = { RegisterUserCommand registerUserCommand ->
    // Determinamos si en este curso se puede inscribir
    response.addHeader("Access-Control-Allow-Origin","*")
    response.addHeader("Content-Type","	application/json;charset=UTF-8")
    // Checamos si el curso está disponible
    if(scheduledCourseService.isAvailableToRegister(params.long("scheduledCourseId"))){
      // Generamos el código de registro o lo obtenemos si ya existe
      def registrationCode = landingService.obtainRegistrationCode(params.email, params.long("scheduledCourseId"))
      // Determinamos la acción a seguir si el usuario es nuevo o no
      def action = actionForANewOrExistingUser(params.email,params.long("scheduledCourseId"),registrationCode)
      // Formamos la URL con el resultado
      def url = request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath+'/'
      url += action+"?code="+registrationCode.token
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

  private def actionForANewOrExistingUser(email,scheduledCourseId,registrationCode) {
    // Buscamos el usuario por su correo
    def user = userService.findUser(email)
    def myAction = ""
    if (user) {
      // Si ya existe el usuario entonces lo notificamos
      notificationService.sendConfirmRegistration(user.email, scheduledCourseId, registrationCode)
      // Definimos la acción
      myAction = "confirmRegistration"
    } else {
      // Si no existe entonces lo invitamos
      notificationService.sendInvitation(email, scheduledCourseId, registrationCode)
      // Definimos la acción
      myAction = "signup"
    }
    myAction
  }
}
