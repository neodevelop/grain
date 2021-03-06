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

class CourseSessionPerRegistration implements Comparable{

  CourseSession courseSession
  Boolean attended = false

  Date dateCreated
	Date lastUpdated

  static belongsTo = [registration:Registration]

  static constraints = {
    lastUpdated display: false, nullable: true
    dateCreated display: false, nullable: true
  }

  int compareTo(obj){
    courseSession.sessionStartTime.compareTo(obj.courseSession.sessionStartTime)
  }
}
