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

import com.synergyj.grain.auth.User

class Registration implements Serializable {

  transient private static final long serialVersionUID = -1L

  Date dateCreated
  Date lastUpdated
  User student
  RegistrationStatus registrationStatus
  Boolean invoice = false

  static hasMany = [promotions: PromotionPerRegistration, payments: Payment, courseSessions:CourseSessionPerRegistration]
  static belongsTo = [scheduledCourse:ScheduledCourse]

  static constraints = {
    lastUpdated display: false, nullable: true
    dateCreated display: false, nullable: true
    student nullable: false
    scheduledCourse nullable: false
    invoice nullable: true
  }

}