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
import java.text.SimpleDateFormat

class CourseSession implements Comparable{
  Date sessionStartTime
  Date sessionEndTime
	CourseModule module
	Date dateCreated
	Date lastUpdated
	
	static hasMany = [teachers:User]
	static belongsTo = [scheduledCourse:ScheduledCourse]

  static dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm")
	
	static constraints = {
    sessionStartTime nullable:false
    sessionEndTime nullable:true
    module nullable:true
		lastUpdated display:false
		dateCreated display:false
	}
	
	String toString(){
    dateFormat.format(this.sessionStartTime)
	}

  int compareTo(obj){
    sessionStartTime.compareTo(obj.sessionStartTime)
  }
}