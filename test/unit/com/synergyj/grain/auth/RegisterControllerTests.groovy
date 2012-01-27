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

import com.synergyj.grain.data.UserService
import grails.plugins.springsecurity.SpringSecurityService
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import grails.test.ControllerUnitTestCase

class RegisterControllerTests extends ControllerUnitTestCase {
  protected void setUp() {
    super.setUp()
    SpringSecurityUtils.metaClass.'static'.getSecurityConfig = { [successHandler: [defaultTargetUrl: "http://localhost:8080/grain"]] }
  }

  protected void tearDown() {
    super.tearDown()
  }

  void testUserRegister() {
    mockForConstraintsTests(RegisterUserCommand)
    def mockUserService = mockFor(UserService)
    mockUserService.demand.createUser(1..1) {RegisterUserCommand usercommand -> new User() }
    def mockSpringSecurityService = mockFor(SpringSecurityService)
    mockSpringSecurityService.demand.reauthenticate(1..1) {  }
    controller.userService = mockUserService.createMock()
    controller.springSecurityService = mockSpringSecurityService.createMock()
    controller.metaClass.message = { LinkedHashMap arg1 -> 'test message output'}
    def userdata = new RegisterUserCommand(email: 'user@server.com', password: 'supersecret')
    controller.user(userdata)
    mockUserService.verify()
  }
}
