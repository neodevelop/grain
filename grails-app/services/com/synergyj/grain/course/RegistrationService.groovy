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

class RegistrationService {

  static transactional = true

  def userService

  def registerFromLanding(RegisterUserCommand userCommand, Long scheduledCourseId){
    userCommand.tos = true // Lo coloco aquí por que aún no lo tengo en la forma
    // Validamos los datos(constraints) del usuario
    if(userCommand.validate()){
      // Buscar si ya existe el usuario
      def user = userService.findUser(userCommand.email)
      // Si no existe entonces se crea
      if(!user){
        user = userService.createUser(userCommand)
      }
      // Se crea registro de inscripción
      def registration = addUserToScheduledCourse(user,scheduledCourseId)
    }else{
      // TODO: Lanzar la excepción para el error
      println "RegisterUserCommand validado FAIL"
      println userCommand.errors.dump()
    }

  }

  def addUserToScheduledCourse(User user, long scheduledCourseId) {
    // Buscamos el curso calendarizado
    def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
    // Creamos la instancia de registro con usuario, curso agendado, fecha de registro
    def registration = new Registration(
        student: user,
        scheduledCourse: scheduledCourse,
        completeCourse: false,
        registrationDate: new Date(),
        registrationStatus: RegistrationStatus.REGISTERED
    )
    // Buscamos si ya esta registrado a este curso
    def userRegisteredToThisCourse =  Registration.countByStudentAndScheduledCourse(user,scheduledCourse)
    // Si esta registrado arrojamos excepción con el respectivo mensaje
    if(userRegisteredToThisCourse){
      throw new RegistrationException(registration:registration,message:"registration.alreadyRegistered")
    }

    // Buscar las sesiones de los cursos a los que el usuario ya está inscrito
    def registrations = Registration.findAllByStudent(user)
    // Definimos una variable para almacenar las sesiones de los cursos registrados
    def sessions =  registrations.collect{ reg ->
      reg.scheduledCourse.courseSessions*.sessionDate
    }

    // Definimos una variable para almacenar las sesiones que se enciman
    def sameSessions = []
    // Iteramos las sesiones de curso registrado una vez aplanadas
    sessions.flatten().each{ courseSessionRegistered ->
      // Iteramos las sesiones del curso calendarizado para comparar
      scheduledCourse.courseSessions*.sessionDate.each{ courseSessionScheduled ->
        // ¿Existe la sesion de curso agendado en el curso registrado?
        if(courseSessionScheduled == courseSessionRegistered)
          sameSessions << courseSessionScheduled // Cierto, entonces agregamos la sesion
      }
    }
    // Si tenemos las mismas sesiones???
    if(sameSessions){
      // Entonces arrojamos excepción
      throw new RegistrationException(registration:registration,message:"registration.sessions.busy")
    }

    // Guardamos el registro
    registration.save()

    // TODO: Notificar al usuario de su registro

    // Regresamos el registro recientemente guardado...
    registration
  }
}
