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

import com.synergyj.grain.auth.RegistrationCodeForScheduledCourse
import com.synergyj.grain.auth.User
import com.synergyj.grain.course.Registration
import com.synergyj.grain.course.ScheduledCourse
import com.synergyj.grain.course.Payment
import com.synergyj.grain.auth.ForgotPasswordCode
import org.hibernate.FetchMode as FM

class NotificationService {

  static transactional = false

  def sendUserRegistration(String email) {
    //Se le envía un correo con la liga para que haga login con los datos que acaba de ingresar
    def user = User.findByEmail(email)
    def mailParams = [
      to:user.email,
      from:"no-reply@synergyj.com",
      subject:"Bienvenido a tu entrenamiento en SynergyJ.com",
      view:'/notification/registration',
      model:[user:user]
    ]
    rabbitSend 'myQueue', mailParams

  }
  // Recibir ir en lugar del objeto
  def sendCourseRegistration(Long registrationId){
    def criteria = Registration.createCriteria()
    def registration = criteria.get{
      eq 'id',registrationId
      fetchMode "promotions",FM.EAGER
    }
    // TODO: Solucionar esto con el fetch de 'promotions'
    registration.promotions.collect { promotionPerCourse -> promotionPerCourse.promotion.description  }
    def scheduledCourse = registration.scheduledCourse
    scheduledCourse.courseSessions.collect{ courseSession -> courseSession.sessionStartTime  }
    scheduledCourse.course.name = scheduledCourse.course.name
    def user = registration.student

    def mailParams = [
      to:registration.student.email,
      from:"no-reply@synergyj.com",
      subject:"Te has inscrito a un curso en SynergyJ.com",
      view:"/notification/scheduledCourse",
      model:[user:user,scheduledCourse:scheduledCourse]
    ]
    rabbitSend 'myQueue', mailParams
  }

  def sendConfirmRegistration(String email,Long scheduledCourseId,registrationCode){
    // Obtenemos el curso calendarizado
    def user = User.findByEmail(email)
    def criteria = ScheduledCourse.createCriteria()
    def scheduledCourse = criteria.get{
        eq 'id',scheduledCourseId
        fetchMode "promotions",FM.EAGER
        fetchMode "courseSessions",FM.EAGER
    }
    // TODO: Solucionar esto con el fetch de 'promotions'
    scheduledCourse.promotions.collect{ promotionPerCourse -> promotionPerCourse.promotion.description  }
    def mailParams = [
      to:user.email,
      from:"no-reply@synergyj.com",
      subject:"Gracias por escoger el curso: ${scheduledCourse.course.name}",
      view:"/notification/confirmRegistration",
      model:[user:user,scheduledCourse:scheduledCourse,registrationCode:registrationCode]
    ]
    rabbitSend 'myQueue', mailParams
  }

  def sendInvitation(String email, Long scheduledCourseId, RegistrationCodeForScheduledCourse registrationCode){
    def criteria = ScheduledCourse.createCriteria()
    def scheduledCourse = criteria.get{
        eq 'id',scheduledCourseId
        fetchMode "promotions",FM.EAGER
        fetchMode "courseSessions",FM.EAGER
    }
    // TODO: Solucionar esto con el fetch de 'promotions'
    scheduledCourse.promotions.collect{ promotionPerCourse -> promotionPerCourse.promotion.description  }
    def mailParams = [
      to:email,
      from:"no-reply@synergyj.com",
      subject:"Gracias por escoger el curso: ${scheduledCourse.course.name}",
      view:"/notification/invitation",
      model:[email:email,scheduledCourse:scheduledCourse,registrationCode:registrationCode]
    ]
    rabbitSend 'myQueue', mailParams
    registrationCode
  }

  def sendPaymentInstructions(Long paymentId){
    def payment = Payment.get(paymentId)
    def mailParams = [
      to:payment.registration.student.email,
      from:"no-reply@synergyj.com",
      subject:"Instrucciones de pago",
      view:"/notification/paymentInstructions",
      model:[payment:payment,registration:payment.registration]
    ]
    rabbitSend 'myQueue', mailParams
  }

  def sendResetPassword(Long forgotPasswordCodeId) {
    def forgotPasswordCode = ForgotPasswordCode.get(forgotPasswordCodeId)
    def mailParams = [
      to:forgotPasswordCode.user.email,
      from:"no-reply@synergyj.com",
      subject:"Instrucciones para restablecer tu contraseña",
      view:"/notification/resetPassword",
      model:[forgotPasswordCode:forgotPasswordCode]
    ]
    rabbitSend 'myQueue', mailParams
  }
}
