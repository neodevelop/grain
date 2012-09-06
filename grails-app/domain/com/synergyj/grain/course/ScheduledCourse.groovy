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

import com.synergyj.geedback.Evaluation
import com.synergyj.grain.auth.User

class ScheduledCourse implements Serializable {

  transient private static final long serialVersionUID = -1L

  Course course
  Date beginDate
  Date limitRegistrationDate
  BigDecimal costByCourse
  BigDecimal costByModule
  ScheduledCourseStatus scheduledCourseStatus
  String geolocation = ''
  String fullAddress = ''
  // Agregamos la duración aquí por que pueden existir cursos que pidan solo ciertos módulos
  Integer durationInHours

  Date dateCreated
  Date lastUpdated

  static constraints = {
    course nullable: false
    beginDate nullable: false
    limitRegistrationDate nullable: false, validator: { val, obj ->
      if (val >= obj.beginDate)
        return 'scheduledcourse.limitRegistrationDate.invalid'
    }
    costByCourse nullable: false
    costByModule nullable: true
    lastUpdated display: false
    dateCreated display: false
    geolocation nullable: true, blank: true, size: 0..200
    fullAddress nullable: true, blank: true, size: 0..1000
    durationInHours nullable: false
  }

  static hasMany = [
    courseSessions: CourseSession,
    promotions: PromotionPerScheduledCourse,
    registrations:Registration,
    expenses:Expense,
    evaluations:Evaluation,
    instructors:User
  ]

  static mapping = {
    cache true
  }

  String toString() {
    "(${id} : ${beginDate} : ${scheduledCourseStatus})"
  }

}