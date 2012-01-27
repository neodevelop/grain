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

import grails.test.*
import com.synergyj.grain.content.ContentType

class ModuleTopicTests extends GrailsUnitTestCase {
  def string10000 = CourseTests.buildString(1000);
  def existingCourse = new Course(name: CourseTests.buildString(50), content: string10000, courseType: CourseType.COURSE, status: Status.PROPOSAL, overview: string10000, prerequisites: string10000, goal: string10000, method: string10000, format: string10000, courseKey: "COURSE", audience: string10000, contentType: ContentType.HTML)
  def existingModule = new CourseModule(name: CourseTests.buildString(50), content: CourseTests.buildString(1000), course: existingCourse)
  def existingModuleTopic = new ModuleTopic(name: CourseTests.buildString(50), content: CourseTests.buildString(1000), module: existingModule, order: 1, contentType: ContentType.TEXTILE)

  protected void setUp() {
    super.setUp()
    mockForConstraintsTests CourseModule, [existingModule]
    mockForConstraintsTests Course, [existingCourse]
    mockForConstraintsTests ModuleTopic, [existingModuleTopic]
  }

  void testConstraintsModule() {
    def moduleTopic = new ModuleTopic(module: null)
    assertFalse moduleTopic.validate()
    assertEquals "nullable", moduleTopic.errors.module
  }

  void testConstraintsType() {
    def moduleTopic = new ModuleTopic(contentType: null)
    assertFalse moduleTopic.validate()
    assertEquals "nullable", moduleTopic.errors.contentType
  }

  void testConstraints() {
    assertTrue existingModuleTopic.validate()
    assertEquals existingModuleTopic.toString(), CourseTests.buildString(50)
  }
}
