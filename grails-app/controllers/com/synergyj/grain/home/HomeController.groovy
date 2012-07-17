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
package com.synergyj.grain.home

import grails.plugins.springsecurity.Secured
import com.synergyj.grain.course.ScheduledCourse
import com.synergyj.grain.course.ScheduledCourseStatus
import com.synergyj.geedback.ExtraInformationForAnswer
import com.synergyj.geedback.KindOfExtraInformation

@Secured(['permitAll()'])
class HomeController {
  def index = {
    def scheduledCourses = ScheduledCourse.findAllByScheduledCourseStatus(ScheduledCourseStatus.SCHEDULED,[max:3])
    // TODO: Corregir la consulta y la forma en que se muestran los testimonios
    def criteria = ExtraInformationForAnswer.createCriteria()
    def comments = criteria.list {
      eq "kindOfExtraInformation", KindOfExtraInformation.PUBLIC_THIS
    }
    def randomSize = new Random().nextInt(comments.size())
    render view:'home', model: [scheduledCourses:scheduledCourses,comments:(comments*2)[randomSize..(randomSize+2)]]
  }
}
