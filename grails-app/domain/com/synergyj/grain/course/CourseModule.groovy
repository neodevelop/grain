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

class CourseModule extends CourseContent implements Comparable<CourseModule> {
	Course course
	Integer order
	SortedSet topics
	
	static hasMany = [topics:ModuleTopic]
	static belongsTo = [course:Course]
	
	static mapping = {
		order column:"module_order"
	}
	
	static constraints = {
		course nullable:false
		order nullable:false,range:1..15
	}
	
	int compareTo(CourseModule other){
		order - other.order
	}
	
	String toString() {
		name
	}
}
