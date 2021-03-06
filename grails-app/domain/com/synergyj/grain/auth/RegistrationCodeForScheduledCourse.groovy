/* Copyright 2009-2010 the original author or authors.
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
package com.synergyj.grain.auth

import com.synergyj.grain.course.ScheduledCourse

class RegistrationCodeForScheduledCourse implements Serializable{

  transient private static final long serialVersionUID = -1L

  String username
  Long scheduledCourseId
  String token = UUID.randomUUID().toString().replaceAll('-', '')
  Date dateCreated

  static mapping = {
    username nullable:false
    scheduledCourseId nullable:false
    version false
  }

  static RegistrationCodeForScheduledCourse create(String email,Long scheduledCourseId) {
    def rc = new RegistrationCodeForScheduledCourse(username: email,scheduledCourseId:scheduledCourseId)
    rc.save(flush: true)
    rc
  }

  def getScheduledCourseForCurrent(){
    ScheduledCourse.get(scheduledCourseId)
  }
}
