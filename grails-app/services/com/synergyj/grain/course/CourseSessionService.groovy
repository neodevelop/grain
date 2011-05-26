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

class CourseSessionService {

    static transactional = true

    def createSession4ScheduledCourse(Long scheduledCourseId,Date sessionStartTime) {
      def scheduledCourse = ScheduledCourse.get(scheduledCourseId)
      if(!scheduledCourse)
        throw ScheduledCourseException(message:"No se encontró el curso agendado...")
      def courseSession = new CourseSession()
      courseSession.scheduledCourse = scheduledCourse
      // TODO: Obtener las horas de inicio y fin desde el front
      Calendar calendar = new GregorianCalendar()
      calendar.setTime(sessionStartTime)
      calendar.set(Calendar.HOUR_OF_DAY,9)
      courseSession.sessionStartTime = calendar.time
      calendar.set(Calendar.HOUR_OF_DAY,18)
      courseSession.sessionEndTime = calendar.time
      if(courseSession.hasErrors()){
        throw ScheduledCourseException(message:"No se puede crear la sesión del curso...")
      }else{
        scheduledCourse.addToCourseSessions(courseSession).save()
      }
      courseSession
    }
}

