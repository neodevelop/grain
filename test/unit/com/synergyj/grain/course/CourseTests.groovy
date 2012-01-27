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

import grails.test.GrailsUnitTestCase
import com.synergyj.grain.content.ContentType
import com.synergyj.grain.course.CourseType
import com.synergyj.grain.course.Status

class CourseTests extends GrailsUnitTestCase {
	def string10000 = buildString(10000);
	def existingCourse = new Course(name:buildString(50), content:string10000, courseType:CourseType.COURSE, status:Status.PROPOSAL, overview:string10000, prerequisites:string10000, goal:string10000, method:string10000, format:string10000, courseKey:"COURSE", audience:string10000, contentType:ContentType.HTML)
	
	protected void setUp() {
		super.setUp()
		
		mockForConstraintsTests Course, [ existingCourse ]
	}
	
	void testConstraintsOverview() {
		def course = new Course(overview:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.overview
		
		course = new Course(overview:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.overview
	}
	
	void testConstraintsAudience() {
		def course = new Course(audience:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.audience
		
		course = new Course(audience:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.audience
	}
	
	void testConstraintsPrerequisites() {
		def course = new Course(prerequisites:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.prerequisites
		
		course = new Course(prerequisites:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.prerequisites
	}
	
	void testConstraintsGoal() {
		def course = new Course(goal:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.goal
		
		course = new Course(goal:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.goal
	}
	
	void testConstraintsMethod() {
		def course = new Course(method:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.method
		
		course = new Course(method:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.method
	}
	
	void testConstraintsFormat() {
		def course = new Course(format:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.format
		
		course = new Course(format:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.format
	}
	
	void testConstraintsCourseKey() {
		def course = new Course(courseKey:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.courseKey
		
		course = new Course(courseKey:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.courseKey
		
		course = new Course(courseKey:"COURSE")
		assertFalse course.validate()
		assertEquals "unique", course.errors.courseKey
		
		course = new Course(courseKey:buildString(21))
		assertFalse course.validate()
		assertEquals "size", course.errors.courseKey
	}
	
	void testConstraintsName() {
		def course = new Course(name:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.name
		
		course = new Course(name:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.name
		
		course = new Course(name:buildString(201))
		assertFalse course.validate()
		assertEquals "size", course.errors.name
	}
	
	void testConstraintsContent() {
		def course = new Course(content:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.content
		
		course = new Course(content:"")
		assertFalse course.validate()
		assertEquals "blank", course.errors.content
	}
	
	void testConstraintsType() {
		def course = new Course(courseType:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.courseType
	}
	
	void testConstraintsContentType() {
		def course = new Course(contentType:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.contentType
	}
	
	void testConstraintsStatus() {
		def course = new Course(status:null)
		assertFalse course.validate()
		assertEquals "nullable", course.errors.status
	}
	
	void testConstraints() {
		existingCourse.courseKey = "COURSE1"
		println existingCourse.validate()
    println existingCourse.errors
	}
	
	static def buildString(length) {
		def str = ""
		
		while (length > 0) {
			str += "A"
			length--
		}
		
		str
	}
	
}
