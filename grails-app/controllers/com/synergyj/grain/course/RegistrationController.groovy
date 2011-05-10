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
package com.synergyj.grain.course

import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import com.synergyj.grain.auth.RegisterUserCommand

class RegistrationController {

  def springSecurityService
  def registrationService

  //static allowedMethods = [addMeFromLanding: "POST"]

  @Secured(['isAuthenticated()'])
  def index = {
    def scheduledCoursesForRegistration = ScheduledCourse.findAllByScheduledCourseStatus(ScheduledCourseStatus.SCHEDULED)
    [scheduledCoursesForRegistration:scheduledCoursesForRegistration]
  }

  @Secured(['isAuthenticated()'])
  def addMeToCourse = {
    def user = springSecurityService.currentUser
    def scheduleCourseId = params.id as Long
    def registration
    try{
      registration =  registrationService.addUserToScheduledCourse(user,scheduleCourseId)
    }catch(RegistrationException ex){
      def result = ['message':g.message(code:ex.message,default:'No te puedes registrar a este curso(varias causas)'),'registration':ex.registration]
      render(result as JSON)
    }
    if(registration){
      render(registration as JSON)
    }
  }
}
