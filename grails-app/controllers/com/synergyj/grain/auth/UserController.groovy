/*
 * Copyright 2002-2008 the original author or authors.
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
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class UserController {

  def springSecurityService

  @Secured(['isAuthenticated()'])
  def me = {
    [user:springSecurityService.currentUser]
  }

  @Secured(['isAuthenticated()'])
  def edit = {
    [user:springSecurityService.currentUser]
  }

  @Secured(['isAuthenticated()'])
  def save = {
    def currentUser = User.findByEmail(springSecurityService.currentUser.email)
    currentUser.properties = params
    currentUser.save()
    redirect action:'me'
  }

  @Secured(['permitAll()'])
  def login = {
    def config = SpringSecurityUtils.securityConfig
    String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"

    [postUrl: postUrl, rememberMeParameter: config.rememberMe.parameter]
  }

  @Secured(['permitAll()'])
  def forgotPassword = {
  }

  @Secured(['permitAll()'])
  def signup = {
    render view: "/register/index", model: [userdata: new RegisterUserCommand()]
  }
}
