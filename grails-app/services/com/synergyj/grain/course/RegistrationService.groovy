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

import com.synergyj.grain.auth.User
import com.synergyj.grain.auth.RegisterUserCommand
import com.synergyj.grain.RegistrationException
import javax.mail.AuthenticationFailedException
import org.codehaus.groovy.grails.commons.GrailsApplication
import grails.util.Environment
import com.synergyj.grain.UserAlreadyExistsException
import com.synergyj.grain.BusinessException
import grails.util.GrailsUtil

class RegistrationService {

  static transactional = true

  def userService
  def notificationService

  def checkIsPayed(Long registrationId){
    def registration = Registration.get(registrationId)
    // Obtenemos la suma de la cantidad que tiene que pagar
    def totalForPayment = 0
    def totalPayed = 0
    registration.payments.each{ thisPayment ->
      // Sumamos el total a pagar
      totalForPayment += thisPayment.amount
      // Sumamos lo que ya pagó
      if(thisPayment.paymentStatus == PaymentStatus.PAYED){
        totalPayed += totalPayed
      }
    }
    // Obtenemos la deuda
    def debt = totalForPayment - totalPayed
    // Si no tiene deuda
    if(!debt){
      // Entonces actualizamos el registro y lo marcamos que ya pago
      registration.registrationStatus = RegistrationStatus.PAYED
    }
  }

  def registerFromLanding(RegisterUserCommand userCommand, Long scheduledCourseId) {
    userCommand.tos = true // TODO: Lo coloco aquí por que aún no lo tengo en la forma
    def user
    def registration
    // Validamos los datos(constraints) del usuario
    if (userCommand.validate()) {
      try {
        user = userService.createUser(userCommand)
        log.info ("Created user")
      } catch (BusinessException ex) {
        GrailsUtil.sanitize(ex).printStackTrace()
      }
      // Se crea registro de inscripción
      registration = addUserToScheduledCourse(user, scheduledCourseId)
    } else {
      // Se lanza la excepción del error
      throw new RegistrationException(message: "register.invalid")
    }
    if (!registration)
      throw new RegistrationException(message: "register.cannot")
    return registration
  }

  def addUserToScheduledCourse(User user, long scheduledCourseId) {
    // Buscamos el curso calendarizado
    def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
    // Creamos la instancia de registro con usuario, curso agendado, fecha de registro
    def registration = new Registration(
        student: user,
        scheduledCourse: scheduledCourse,
        completeCourse: false,
        registrationStatus: RegistrationStatus.REGISTERED
    )
    // Buscamos si ya esta registrado a este curso
    //def userRegisteredToThisCourse = Registration.countByStudentAndScheduledCourse(user, scheduledCourse)
    def userRegisteredToThisCourse = Registration.countByStudentAndScheduledCourse(user, scheduledCourse)
    // Si esta registrado arrojamos excepción con el respectivo mensaje
    if (userRegisteredToThisCourse) {
      throw new RegistrationException(message: "registration.alreadyRegistered", registration: registration)
    }

    /*
    // Buscar las sesiones de los cursos a los que el usuario ya está inscrito
    def registrations = Registration.findAllByStudent(user)

    // Definimos una variable para almacenar las sesiones de los cursos registrados
    def sessions = registrations.collect { reg ->
      reg.scheduledCourse.courseSessions*.sessionStartTime
    }

    // Definimos una variable para almacenar las sesiones que se enciman
    def sameSessions = []
    // Iteramos las sesiones de curso registrado una vez aplanadas
    sessions.flatten().each { courseSessionRegistered ->
      // Iteramos las sesiones del curso calendarizado para comparar
      scheduledCourse.courseSessions*.sessionStartTime.each { courseSessionScheduled ->
        // ¿Existe la sesion de curso agendado en el curso registrado?
        if (courseSessionScheduled == courseSessionRegistered)
          sameSessions << courseSessionScheduled // Cierto, entonces agregamos la sesion
      }
    }
    // Si tenemos las mismas sesiones???
    if (sameSessions) {
      // Entonces arrojamos excepción
      throw new RegistrationException(message: "registration.sessions.busy", registration: registration)
    }
    */


    if(!registration.validate()) {
      registration.errors.each {
        println it.dump()
      }

      throw new RegistrationException(message: "registration.sessions.busy", registration: registration)
    }
    // Guardamos el registro
    registration.save(flush: true)

    // Notificamos al usuario que se ha inscrito al curso
    notificationService.sendCourseRegistration(registration)

    // Regresamos el registro recientemente guardado...
    registration
  }
}
