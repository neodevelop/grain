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
import grails.util.Environment
import com.synergyj.grain.course.ScheduledCourse
import com.synergyj.grain.course.Payment

class NotificationService {

  // TODO: Optimizar el envío de correo para los ambientes de desarrollo y los mensajes a enviar

  def mailService

  static transactional = false

  def sendUserRegistration(User user) {
    //Se le envía un correo con la liga para que haga login con los datos que acaba de ingresar
    switch(Environment.current){
      case Environment.DEVELOPMENT:
        log.debug("${Environment.current} - Mail con Objeto: ${user}")
        break
      case Environment.TEST:
        log.debug("${Environment.current} Correo de registro...")
        break
      case Environment.PRODUCTION:
        mailService.sendMail {
          to user.email
          from "no-reply@synergyj.com"
          subject "Bienvenido a tu entrenamiento en SynergyJ.com"
          body(view:"/notification/registration",model:[user:user])
        }
        break
    }
  }

  def sendCourseRegistration(Registration registration){
    switch(Environment.current){
      case Environment.DEVELOPMENT:
        log.debug("${Environment.current} - Mail con Objeto: ${registration}")
        break
      case Environment.TEST:
        log.debug("${Environment.current} Correo de registro...")
        break
      case Environment.PRODUCTION:
        mailService.sendMail {
          to registration.student.email
          from "no-reply@synergyj.com"
          subject "Te has inscrito a un curso en SynergyJ.com"
          body(view:"/notification/scheduledCourse",model:[user:registration.student,scheduledCourse:registration.scheduledCourse])
        }
        break
    }
  }

  def sendConfirmRegistration(User user,Long scheduledCourseId,registrationCode){
    // Obtenemos el curso calendarizado
    def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
    switch(Environment.current){
      case Environment.DEVELOPMENT:
        log.debug("${Environment.current} - Send Confirm Registration ${user} for ${scheduledCourse}")
        break
      case Environment.TEST:
        log.debug("${Environment.current} - Send Confirm Registration ${user} for ${scheduledCourse}")
        break
      case Environment.PRODUCTION:
        mailService.sendMail {
          to user.email
          from "no-reply@synergyj.com"
          subject "Gracias por escoger el curso: ${scheduledCourse.course}"
          body(view:"/notification/confirmRegistration",model:[user:user,scheduledCourse:scheduledCourse,registrationCode:registrationCode])
        }
        break
    }
  }

  def sendInvitation(String email, Long scheduledCourseId, RegistrationCode registrationCode){
    def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
    switch(Environment.current){
      case Environment.DEVELOPMENT:
        log.debug("${Environment.current} - Send Invitation ${email} for ${scheduledCourse}")
        break
      case Environment.TEST:
        log.debug("${Environment.current} - Send Invitation ${email} for ${scheduledCourse}")
        break
      case Environment.PRODUCTION:
        mailService.sendMail {
          to email
          from "no-reply@synergyj.com"
          subject "Gracias por escoger el curso: ${scheduledCourse.course}"
          body(view:"/notification/invitation",model:[email:email,scheduledCourse:scheduledCourse,registrationCode:registrationCode])
        }
        break
    }
    registrationCode
  }

  def sendPaymentInstructions(Registration registration,Payment payment){
    switch(Environment.current){
      case Environment.DEVELOPMENT:
        log.debug("${Environment.current} - Send payment instructions ${payment} for ${registration}")
        break
      case Environment.TEST:
        log.debug("${Environment.current} - Send payment instructions  ${payment} for ${registration}")
        break
      case Environment.PRODUCTION:
        mailService.sendMail {
          to registration.student.email
          from "no-reply@synergyj.com"
          subject "Instrucciones de pago"
          body(view:"/notification/paymentInstructions",model:[payment:payment,registration:registration])
        }
        break
    }
  }
}
