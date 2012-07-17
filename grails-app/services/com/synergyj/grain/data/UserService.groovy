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
package com.synergyj.grain.data

import com.synergyj.grain.BusinessException
import com.synergyj.grain.UserRegistrationException

import com.synergyj.grain.auth.User
import com.synergyj.grain.auth.Role
import com.synergyj.grain.auth.PersonAuthority

class UserService {

  static transactional = true
  def springSecurityService
  def notificationService

  def findUser(String email) {
    def user = User.findByEmail(email.toLowerCase())
    user
  }

  def createUser(userCommand) throws BusinessException {
    def user = new User(userCommand.properties)

    user.password = user.password.toLowerCase()
    user.enabled = true
    user.accountExpired = false
    user.accountLocked = false
    user.emailShow = true
    user.passwordExpired = false

    if (user.validate() && user.save()) {
      // Buscamos el rol del usuario
      def userRole = Role.findByAuthority("ROLE_USER")
      // Le asignamos el rol al usuario
      PersonAuthority.create user, userRole, true
      // Notificación de la creación de la cuenta del usuario
      notificationService.sendUserRegistration(user.email)
      log.info 'User created'
    } else {
      throw new UserRegistrationException('user.registration.error', user)
    }

    user
  }

}
