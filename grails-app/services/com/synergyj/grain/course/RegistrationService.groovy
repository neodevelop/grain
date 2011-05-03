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

class RegistrationService {

  static transactional = true

  def addUserToScheduledCourse(User user, long scheduledCourseId) {
    // Buscamos el curso calendarizado
    def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
    // Creamos la instancia de registro con usuario, curso agendado, fecha de registro
    def registration = new Registration(
        student: user,
        scheduledCourse: scheduledCourse,
        completeCourse: false,
        registrationDate: new Date()
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
    // Regresamos el registro recientemente guardado...
    registration
  }
}
