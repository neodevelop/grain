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

import com.synergyj.grain.auth.User
import com.synergyj.grain.auth.RegisterUserCommand

class UserService {

  static transactional = true
  def springSecurityService

  def findUser(email) {
    User.findByEmail(email)
  }

  def createUser(RegisterUserCommand userCommand) {
    //springSecurityService
    def user = new User(email: userCommand.email, password: userCommand.password)
    try {
      if (user.hasErrors()) {
        user.errors.each {
          println it
        }
      }
      user.save(flush: true)
    } catch (Throwable t) {
      log.warn 'Cant save user', t
      t.printStackTrace()
    }
  }
}
