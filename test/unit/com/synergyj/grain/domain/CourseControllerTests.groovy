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

import grails.test.*
import com.synergyj.grain.content.ContentType

class CourseControllerTests extends ControllerUnitTestCase {
	def domain
	
	protected void setUp() {
		super.setUp()

		def string10000 = CourseTests.buildString(10000);
		domain = new Course(name:CourseTests.buildString(50), content:string10000, courseType:CourseType.COURSE, status:Status.PROPOSAL, overview:string10000, prerequisites:string10000, goal:string10000, method:string10000, format:string10000, courseKey:"COURSE", audience:string10000, contentType:ContentType.HTML)
		
		mockDomain Course, [domain]
	}

	protected void tearDown() {
		super.tearDown()
	}
	
	void testDetailWithExistingCourse() {
		mockParams.id = 1
		controller.detail()
		
		assertEquals 1, renderArgs.model.size()
		assertEquals domain, renderArgs.model.courseInstance
		assertEquals "detail", renderArgs.view
	}
}
