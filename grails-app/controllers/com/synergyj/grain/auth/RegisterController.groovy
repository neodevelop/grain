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

import com.synergyj.grain.BusinessException

@Secured(['permitAll'])
class RegisterController {
  def userService

  def index = { }

  def user = { RegisterUserCommand userdata ->
    def user
    if (userdata.hasErrors()) {
      userdata.password = ''
      render view: "/register/index", model: [userdata: userdata]
    } else {
      try {
        user = userService.createUser(userdata)
      } catch (BusinessException be) {
        flash.error = g.message(code: be.message, args: [userdata.email])
        render view: "/register/index", model: [userdata: userdata]
        return
      }
      render view:"success",model:[user:user]
    }
  }

}
