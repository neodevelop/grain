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
package com.synergyj.grain.auth

import grails.plugins.springsecurity.Secured

@Secured(['permitAll'])
class RegisterController {
  def userService
  def index = { }
  def user = { RegisterUserCommand userdata ->
    def userFound = userService.findUser(userdata.email)
    if (userdata.hasErrors() || userFound) {
      if (userFound) {
        flash.message = g.message(code: 'register.user.already.exists', args: [userdata.email])
      }
      userdata.password = ''
      render view: "/register/index", model: [userdata: userdata]
      return
    }
    userService.createUser(userdata)
    render 'Chido'
  }
}
