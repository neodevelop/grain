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
package com.synergyj.grain.event

import com.synergyj.grain.auth.RegistrationCode
import com.synergyj.grain.auth.User
import com.synergyj.grain.course.Registration

class NotificationService {

  def mailService

  static transactional = false

  def sendUserRegistration(User user) {
    //Se le envía un correo con la liga para que haga login con los datos que acaba de ingresar
    mailService.sendMail {
      to user.email
      from "no-reply@synergyj.com"
      subject "Bienvenido a tu entrenamiento en SynergyJ.com"
      body(view:"/notification/registration",model:[user:user])
    }
  }

  def sendCourseRegistration(Registration registration){
    mailService.sendMail {
      to registration.student.email
      from "no-reply@synergyj.com"
      subject "Te has inscrito a un curso en SynergyJ.com"
      body(view:"/notification/scheduledCourse",model:[user:registration.student,scheduledCourse:registration.scheduledCourse])
    }
  }
}
