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

class ScheduledCourseService {

  static transactional = true

  def userService

  def isAvailableToRegister(Long scheduledCourseId) {
    def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
    def available = false
    if (scheduledCourse) {
      switch (scheduledCourse.scheduledCourseStatus) {
        case [ScheduledCourseStatus.PLANNING, ScheduledCourseStatus.SCHEDULED]:
          available = true
          break
        default:
          available = false
          break
      }
    }
    available
  }

  def addStudentsFromCsvString(String csvString, Long id) {
    def newUsersCount = 0
    def newRegistrationsCount = 0
    //Obtenemos el curso actual
    def scheduledCourse = ScheduledCourse.get(id)
    // Iteramos las líneas que vienen en el String
    csvString.eachLine { line ->
      // El formato de la línea debe ser "email,nombre,apellidos"
      def record = line.tokenize(',')
      // Buscamos el usuario
      def user = userService.findUser("${record[0] as String}")
      // Si no existe lo creamos con un password default
      if (!user) {
        user = new User()
        user.email = record[0] as String
        user.firstName = record[1] as String
        user.lastName = record[2] as String
        user.password = "${new Date().toString()}"
        user.enabled = true
        user.accountExpired = false
        user.accountLocked = false
        user.emailShow = true
        user.passwordExpired = false
        // Guardamos el usuario
        user.save()
        newUsersCount++
      }
      // Buscamos el registro para determinar si existe
      def registration = Registration.findByStudentAndScheduledCourse(user, scheduledCourse)
      // Si no hay registro
      if (!registration) {
        // Creamos el registro
        registration = new Registration(student: user, registrationStatus: RegistrationStatus.REGISTERED)
        newRegistrationsCount++
      }
      // Agregamos el registro al curso calendarizado
      scheduledCourse.addToRegistrations(registration)
      [newUsersCount:newUsersCount,newRegistrationsCount:newRegistrationsCount]
    }
  }
}
