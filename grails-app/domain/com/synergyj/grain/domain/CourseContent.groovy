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
package com.synergyj.grain.domain

/**
 * Base domain class. This class defines the common properties related to Courses
 */
abstract class CourseContent {
	String name
	String content
	Date dateCreated
	Date lastUpdated
	
	static constraints = {
		name blank:false,nullable:false,size:1..100
		content blank:false,nullable:false
		
		lastUpdated display:false
		dateCreated display:false
	}
	
	static mapping = {
		content type:"text"
		tablePerHierarchy false
	}
}
