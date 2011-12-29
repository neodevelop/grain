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

class CalendarService {
  static transactional = true

  def obtainSessionsFromFromScheduledCourse(Long scheduledCourseId) {
    def criteria = CourseSession.createCriteria()
    // Obtenemos las sesiones de un curso calendarizado ordenadas por fecha de inicio
    def sessions = criteria.list {
      scheduledCourse {
        eq("id", scheduledCourseId)
      }
      order("sessionStartTime", "asc")
    }
    sessions
  }

  def obtainEventsByStatusList(statusList) {
    // Buscamos cursos calendarizados por un grupo de estados
    def scheduledCourses = ScheduledCourse.findAllByScheduledCourseStatusInList(statusList)
    // Iniciamos nuestro valor de retorno
    def events = []
    // Iteramos los cursos encontrados
    scheduledCourses.each { sc ->
      // Buscamos sesiones para este curso caledarizado
      def sessions = this.obtainSessionsFromFromScheduledCourse(sc.id)
      // Generamos los objetos eventInfo iterando las sesiones
      def counter = 1
      sessions.each { courseSession ->
        def properties = [
          id: courseSession.id,
          title: "${sc.course.name} - Sesión ${counter++}",
          start: courseSession.sessionStartTime,
          end: courseSession.sessionEndTime,
          url: sc?.course?.urlLandingPage ?: "http://synergyj.com",
          backgroundColor: sc.course.backgroundColor,
          borderColor: sc.course.borderColor,
          textColor: sc.course.textColor
        ]
        def eventInfo = new EventInfo(properties)
        events << eventInfo
      }
    }
    events
  }
}
