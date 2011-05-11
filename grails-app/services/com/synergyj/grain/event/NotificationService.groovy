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

class NotificationService {

  def mailService

  static transactional = false

  def sendNewRegistration(User user) {
    // TODO: Se le envía un correo con la liga para que haga login con los datos que acaba de ingresar
    /*
    mailService.sendMail {
      to registration.username
      from "no-reply@synergyj.com"
      subject "Activa tu cuenta en SynergyJ.com"
      body(view:"/mail/registrationNotification",model:[registration:registration])
    }*/

    println "Envío de mail a ${user.email}"
  }
}
