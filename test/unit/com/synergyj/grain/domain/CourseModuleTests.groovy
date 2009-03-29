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

import com.synergyj.grain.content.ContentType

class CourseModuleTests extends grails.test.GrailsUnitTestCase {
	//def existingCourse = new Course(name:CourseTests.buildString(50), content:CourseTests.buildString(10000), type:CourseType.COURSE)
	def existingModule = new CourseModule(name:CourseTests.buildString(50), content:CourseTests.buildString(10000), course:new Course(), order:1, contentType:ContentType.HTML)
	
	protected void setUp() {
		super.setUp()
		
		mockForConstraintsTests CourseModule, [ existingModule ]
		//mockForConstraintsTests Course, [ existingCourse ]
	}
	
	void testConstraintsCourse() {
		def module = new CourseModule()
		assertFalse module.validate()
		assertEquals "nullable", module.errors.course
	}
	
	void testConstraintsType() {
		def module = new CourseModule()
		assertFalse module.validate()
		assertEquals "nullable", module.errors.contentType
	}
	
	void testConstraintsOrder() {
		def module = new CourseModule()
		assertFalse module.validate()
		assertEquals "nullable", module.errors.order
	}
	
	void testModuleOrder() {
		def module1 = new CourseModule(order:1)
		def module2 = new CourseModule(order:2)
		
		assertTrue(module1 < module2)
		
		module1.order = 5
		assertTrue(module1 > module2)
		
		module2.order = 5
		assertTrue(module1 == module2)
	}
	
	void testConstraints() {
		assertTrue existingModule.validate()
		assertEquals existingModule.toString(), CourseTests.buildString(50)
	}
}