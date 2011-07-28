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

class ScheduledCourse{
	Course course
	Date beginDate
	Date limitRegistrationDate
	BigDecimal costByCourse
	BigDecimal costByModule
  ScheduledCourseStatus scheduledCourseStatus
  String geolocation = ''
  String fullAddress = ''
	
	Date dateCreated
	Date lastUpdated
	
	static constraints = {
    course nullable:false
    beginDate nullable:false
    limitRegistrationDate nullable:false,validator: { val, obj ->
      if(val >= obj.beginDate )
        return ['scheduledcourse.limitRegistrationDate.invalid']
    }
    costByCourse nullable: false,blank: false
    costByModule nullable: true,blank: true
		lastUpdated display:false
		dateCreated display:false
    geolocation nullable: true, blank: true, size: 0..200
    fullAddress nullable: true, blank: true, size: 0..1000
    studentsGroup nullable: true
	}
	
	static hasMany = [courseSessions:CourseSession,promotions:PromotionPerScheduledCourse]
  static hasOne = [studentsGroup:StudentsGroup]

  String toString(){
    "${course} : ${beginDate} : ${scheduledCourseStatus}"
  }
}