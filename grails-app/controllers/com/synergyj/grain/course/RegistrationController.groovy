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
import grails.plugins.springsecurity.Secured

import com.synergyj.grain.RegistrationException
import com.synergyj.grain.auth.RegistrationCodeForScheduledCourse
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class RegistrationController {

  def springSecurityService
  def registrationService

  //static allowedMethods = [addMeFromLanding: "POST"]

  def confirm = {
    def model = [:]
    // Obtenemos el id del curso calendarizado que viene de la forma de registro del usuario
    def scheduledCourseId = params.long('scheduledCourseId')
    // Si no se obtuvo, entonces viene de la landing de un usuario que ya existe
    if(!scheduledCourseId){
      // Buscamos el código de registro
      def registrationCode = RegistrationCodeForScheduledCourse.findByToken(params.code)
      // Obtenemos el id del curso calendarizado
      scheduledCourseId = registrationCode.scheduledCourseId
      // Asignamos el email
      model.email = registrationCode.username
    }
    // Obtenemos el curso calendarizado
    def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
    // Lo agregamos al modelo
    model.scheduledCourse = scheduledCourse
    // Agregamos los parámetros de seguridad
    model.postUrl = "${request.contextPath}${SpringSecurityUtils.securityConfig.apf.filterProcessesUrl}"
    model.rememberMeParameter = SpringSecurityUtils.securityConfig.rememberMe.parameter
    model
  }

  @Secured(['isAuthenticated()'])
  def index = {
    def scheduledCoursesForRegistration = ScheduledCourse.findAllByScheduledCourseStatus(ScheduledCourseStatus.SCHEDULED)
    [scheduledCoursesForRegistration:scheduledCoursesForRegistration]
  }

  @Secured(['isAuthenticated()'])
  def addMeToCourse = {
    def user = springSecurityService.currentUser
    def scheduledCourseId = params.long('scheduledCourseId')
    def registration = null
    try{
      registration =  registrationService.addUserToScheduledCourse(user,scheduledCourseId)
    }catch(RegistrationException ex){
      flash.message = g.message(code:ex.message,default:'No te puedes registrar a este curso(varias causas)')
      redirect action:'confirm',params: [scheduledCourseId:scheduledCourseId]
    }
    if(registration){
      redirect controller: 'payment', action: 'startForCurrentUser', id: registration.id
    }
  }

  def delete = {
    def registration = Registration.get(params.id)
    registration.delete()
    render ""
  }

  def cancel = {
    def registration = Registration.get(params.id)
    registration.registrationStatus = RegistrationStatus.CANCELLED
    render(contentType:"text/json") {
      registrationId = registration.id
      registrationStatus = registration.registrationStatus
      message = 'Cancelado'
    }
  }

  def toggleFinished = {
    def registration = Registration.get(params.id)
    def isFinished = true
    if (registration.registrationStatus == RegistrationStatus.FINISHED){
      registration.registrationStatus = RegistrationStatus.INSCRIBED_AND_PAYED_IN_GROUP
      isFinished = false
    }else{
      registration.registrationStatus = RegistrationStatus.FINISHED
    }
    response.addHeader("Access-Control-Allow-Origin","*")
    response.addHeader("Content-Type","	application/json;charset=UTF-8")
    render([finished:isFinished] as JSON)
  }
}
