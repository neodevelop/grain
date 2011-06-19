/*
 * Copyright 2002-2010 the original author or authors.
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
package com.synergyj.grain.auth

import grails.plugins.springsecurity.Secured

import com.synergyj.grain.BusinessException
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

@Secured(['permitAll'])
class RegisterController {
  def userService
  def springSecurityService

  def index = { }

  //Usamos un command para recibir el formulario
  def user = { RegisterUserCommand userdata ->
    try {
      // Creamos el usuario
      def user = userService.createUser(userdata)
      // Autenticamos directamente al usuario
      springSecurityService.reauthenticate(user.email,user.password)
    } catch (BusinessException be) {
      // Si existe un error, tomamos la ex y la mandamos en el flash
      flash.error = g.message(code: be.message, args: [userdata.email])
      // Redireccionamos a la vista de registro con el error
      userdata.password = ''
      render view: "/user/signup", model: [userdata: userdata]
      return
    }
    // Obtenemos la uri default para la seguridad
    def uri = SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
    // Pero si trae un parámetro de suscripción
    if(params?.scheduledCourseId){
      // Lo mandamos a otra vista para mostrarle su registro
      uri = "/confirmRegistration?scheduledCourseId=${params.scheduledCourseId}"
    }
    // Redireccionamos
    redirect uri:uri
  }

}
