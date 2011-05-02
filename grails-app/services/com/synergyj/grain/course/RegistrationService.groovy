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
    def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
    def registration = new Registration(
        student: user,
        scheduledCourse: scheduledCourse,
        completeCourse: false,
        registrationDate: new Date(),
        courseSessions: scheduledCourse.courseSessions
    )
    // TODO: Validar que el usuario no este registrado previamente
    // TODO: Validar y avisar cuando un usuario quiera registrarse a otro curso y no deba por interferncia en sus clases
    // TODO: Guardar el registro
    println registration.dump()
    println registration.validate()
    registration
  }
}
