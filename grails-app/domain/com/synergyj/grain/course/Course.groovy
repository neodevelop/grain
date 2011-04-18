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

import com.synergyj.grain.course.CourseType
import com.synergyj.grain.course.Status
import com.synergyj.grain.course.CourseModule

class Course extends CourseContent {
  String name
	String overview
	String audience
	String prerequisites
	String goal
	String method
	String format
	String courseKey
	CourseType courseType
	Status status
	SortedSet modules
	
	static hasMany = [modules:CourseModule]
	
	static constraints = {
		overview nullable:false,blank:false
		audience nullable:false,blank:false
		prerequisites nullable:false,blank:false
		goal nullable:false,blank:false
		method nullable:false,blank:false
		format nullable:false,blank:false
		courseKey nullable:false,blank:false,unique:true,size:1..20
		courseType nullable:false
		status nullable:false
	}
	
	static mapping = {
		overview type:"text"
		audience type:"text"
		prerequisites type:"text"
		goal type:"text"
		method type:"text"
		format type:"text"
	}
	
	String toString() {
		name
	}
}
