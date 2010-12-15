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
import com.synergyj.grain.auth.RegisterUserCommand
import com.synergyj.grain.auth.RegistrationCode
import com.synergyj.grain.auth.User
import com.synergyj.grain.UserAlreadyExistsException

class UserService {

  static transactional = true
  def springSecurityService
  def notificationService

  def findUser(email) {
    email ? User.findByEmail(email) : null
  }

  def createUser(userCommand) throws BusinessException {
    def userFound = findUser(userCommand.email)
    if(userFound) { throw new UserAlreadyExistsException('register.user.already.exists', userCommand.email)}
    def user = new User(userCommand.properties)
    String salt = userCommand.email

    user.enabled = true
    user.accountExpired = false
    user.accountLocked = true
    user.emailShow = true
    user.passwordExpired = false
    user.password = springSecurityService.encodePassword(user.password, salt)

    if (user.validate() && user.save(flush: true)) {
      log.info 'User created'
    } else {
      throw new UserRegistrationException('user.registration.error', user)
    }

    def registration = RegistrationCode.create(user.email)
    notificationService.sendNewRegistration(registration)

    user
  }
}
