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
package com.synergyj.grain.auth

import grails.plugins.springsecurity.Secured
import com.synergyj.grain.course.Registration
import com.synergyj.grain.course.ScheduledCourse
import com.synergyj.grain.course.ScheduledCourseStatus
import grails.converters.JSON
import com.synergyj.grain.course.Payment
import com.synergyj.grain.course.PaymentStatus
import org.grails.mail.MailService

class UserController {

  def springSecurityService
  def paymentService
  def notificationService

  @Secured(['isAuthenticated()'])
  def me = {
    User user = springSecurityService.currentUser
    def roleAdmin = user.authorities.find { it.authority == "ROLE_ADMIN" }
    if(roleAdmin){
      // Obtenemos los cursos con el status SCHEDULED, los que se van a abrir
      def currentScheduledCourses = ScheduledCourse.findAllByScheduledCourseStatus(ScheduledCourseStatus.SCHEDULED)
      // Obtenemos los registros(Registration) de cada curso calendarizado
      def registrationsPerScheduledCourse = [:]
      // Iteramos los cursos calendarizados
      currentScheduledCourses.each{ scheduledCourse ->
        // Obtenemos los registros por curso
        def registrations = Registration.findAllByScheduledCourse(scheduledCourse)
        // Creamos una entrada en el mapa con el key CourseKey y el Value la lista de Registrations
        registrationsPerScheduledCourse."${scheduledCourse.course.courseKey}" = registrations
      }
      return [user:user,scheduledCourseList:currentScheduledCourses,registrationsPerScheduledCourse:registrationsPerScheduledCourse]
    }else{
      def myRegistrations = Registration.findAllByStudent(user)
      return [user:user,myRegistrations:myRegistrations]
    }
  }

  @Secured(['isAuthenticated()'])
  def edit = {
    [user:springSecurityService.currentUser]
  }

  @Secured(['isAuthenticated()'])
  def save = {
    def currentUser = User.findByEmail(springSecurityService.currentUser.email)
    currentUser.properties = params
    currentUser.save()
    if(params?.isAjax){
      response.addHeader("Content-Type","	application/json;charset=UTF-8")
      render currentUser as JSON
    }else{
      redirect action:'me'
    }
  }

  @Secured(['permitAll()'])
  def forgotPassword = {
  }

  @Secured(['permitAll()'])
  def sendResetInstructions = {
    def user = User.findByEmail(params.email)
    if(user){
      // Generar un código de recuperación
      def forgotPasswordCode = new ForgotPasswordCode(user:user)
      forgotPasswordCode.save(flush:true)
      // Enviarlo por correo
      notificationService.sendResetPassword(forgotPasswordCode)
      // println "${request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath+'/resetPassword?code='+forgotPasswordCode?.token}"
      flash.message = "${message(code:'user.found',args:[params.email])}"
    }else{
      flash.message = "${message(code:'user.notfound',args:[params.email])}"
    }
    redirect action: 'forgotPassword'
  }

  @Secured(['permitAll()'])
  def resetPassword = {
    redirect action:'changePassword',id:params.code
  }

  @Secured(['permitAll()'])
  def signup = {
    def model = [userdata: new RegisterUserCommand()]
    // Si trae un código lo buscamos
    if(params.code){
      def registrationCode = RegistrationCode.findByToken(params.code)
      model.registrationCode = registrationCode
      // Ponemos los datos del curso calendarizado para mostrarlos
      model.scheduledCourse = ScheduledCourse.get(registrationCode.scheduledCourseId)
    }
    model
  }

  def accountLocked = {}

  @Secured(['isAuthenticated()'])
  def simpleProfile = {
  }

  @Secured(['permitAll()'])
  def changePassword = {
    def model = [:]
    if(params?.id){
      def forgotPasswordCode = ForgotPasswordCode.findByToken(params.id)
      if(forgotPasswordCode){
        forgotPasswordCode.used = true
        model.email = forgotPasswordCode.user.email
      }else{
        flash.message = "${message(code:'forgotPasswordCode.notfound')}"
        redirect action: 'forgotPassword'
      }
    }
    return model
  }

  @Secured(['permitAll()'])
  def updatePassword = {
    def user = springSecurityService.currentUser
    if(!user && params?.email)
      user = User.findByEmail(params.email)
    else{
      redirect action: 'forgotPassword'
      return
    }
    user.password = params.password
    flash.message = "${message(code:'login.passwordUpdated')}"
    redirect controller: 'login', action: 'auth'
  }

}
