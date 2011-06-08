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

class LandingController {

  def userService
  def notificationService

  @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
  def addMe = { RegisterUserCommand registerUserCommand ->
    // Recibimos el email y el id de curso calendarizado
    def email = params.email
    def scheduledCourseId = params.long("scheduledCourseId")
    // Generamos una URL alternativa para regresarla en caso de no se envíe el correo o el usuario quiera proceder sin ver el correo
    def url = request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath+'/'
    // Buscamos el usuario por su correo
    def user = userService.findUser(email)
    // Si existe entonces se le envia una notificación de que ha quedado registrado
    if(user){
      notificationService.sendConfirmRegistration(user,scheduledCourseId)
      url += "confirmRegistration?email=${user.email}&scheduledCourseId=${scheduledCourseId}"
    }else{
      // Si no existe entonces se le envía una invitación para registrarse en donde le enviamos el curso al que esta interesado
      notificationService.sendInvitation(email,scheduledCourseId)
      url += "signup?email=${email}&scheduledCourseId=${scheduledCourseId}"
    }

    // Regresamos una respuesta para el formulario de registro
    response.addHeader("Access-Control-Allow-Origin","*")
    response.addHeader("Content-Type","	application/json;charset=UTF-8")
    render([url:url] as JSON)
  }

  @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
  def create = {
  }
}
