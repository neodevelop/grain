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

import grails.plugins.springsecurity.Secured
import com.synergyj.grain.auth.User
import grails.converters.JSON

@Secured(["hasRole('ROLE_ADMIN')"])
class StudentsGroupController {
  def create = {
    def scheduledCourse = ScheduledCourse.get(params.id)
    def months = ['ENERO','FEBRERO','MARZO','ABRIL','MAYO','JUNIO','JULIO','AGOSTO','SEPTIEMBRE','OCTUBRE','NOVIEMBRE','DICIEMBRE']
    def keyStudentsGroup = "${scheduledCourse.course.courseKey}-${months[scheduledCourse.beginDate.month - 1]}"
    if(!scheduledCourse.studentsGroup){
      scheduledCourse.studentsGroup = new StudentsGroup(scheduledCourse: scheduledCourse,keyStudentsGroup: keyStudentsGroup)
      scheduledCourse.save(flush:true)
    }
    render """
      <a href='${g.createLink(controller:'studentsGroup',action:'show',id:scheduledCourse?.studentsGroup?.id)}'>
        ${g.message(code:'studentsGroup.show',default:'See group')}
      </a>
    """
  }

  def show = {
    // Obtenemos el grupo de estudiantes
    def studentsGroup = StudentsGroup.get(params.id)
    // Buscamos los registros al curso calendarizado
    def registrations = Registration.findAllByScheduledCourse(studentsGroup.scheduledCourse)
    // Obtenemos los usuarios de todos los registros
    def users = registrations*.student
    // Obtenemos los usuarios que SI están en el grupo
    def studentsInGroup = studentsGroup.students
    // Obtenemos los usuarios que NO están en el grupo
    def studentsNoGroup = []
    users.each{ user ->
      def userFound = studentsInGroup.find { it.email == user.email }
      if(!userFound)
       studentsNoGroup << user
    }

    // Obtenemos los registros que SI están en un grupo
    def registrationsInGroup = []
    studentsInGroup.each { student ->
      def registrationFound = registrations.find { it.student.email == student.email }
      if(registrationFound)
        registrationsInGroup << registrationFound
    }

    // Obtenemos los registros que NO están en un grupo
    def registrationsNoGroup = registrations - registrationsInGroup

    [studentsGroup:studentsGroup,registrationsInGroup:registrationsInGroup,registrationsNoGroup:registrationsNoGroup ]
  }

  def addStudent = {
    def studentsGroup = StudentsGroup.get(params.long("studentsGroupId"))
    def user = User.get(params.id)
    studentsGroup.addToStudents(user)
  }

  def removeStudent = {
    def studentsGroup = StudentsGroup.get(params.long("studentsGroupId"))
    def user = User.get(params.id)
    studentsGroup.removeFromStudents(user)
  }

  def attendance = {
    // Obtenemos el grupo de estudiantes
    def studentsGroup = StudentsGroup.get(params.id)
    // Obtenemos el curso calendarizado
    def scheduledCourse = studentsGroup.scheduledCourse
    // Obtenemos las sesiones del curso calendarizado
    def scheduledCourseSessions = scheduledCourse.courseSessions
    // Preparamos los registrations a mandar a la vista
    def registrations = []
    // Iteramos a los alumnos para ver si tienen esas sesiones
    studentsGroup.students.each{ student ->
      // Buscamos el registro del curso para un estudiante
      def registration = Registration.findByStudent(student)
      // Si no tiene sesiones de curso entonces
      if(!registration.courseSessions.size()){
        // Iteramos las sesiones del curso calendarizado
        scheduledCourseSessions.each{ scheduledCourseSession ->
          // Las replicamos a cada alumno
          def courseSessionPerRegistration = new CourseSessionPerRegistration(
            registration:registration,
            courseSession:scheduledCourseSession
          )
          // Agregamos la sesión de curso calendarizado al estudiante
          registration.addToCourseSessions(courseSessionPerRegistration)
        }
      }
      registrations << registration
    }
    [studentsGroup:studentsGroup,registrations:registrations]
  }

  def checkAttendance = {
    def courseSessionPerRegistration = CourseSessionPerRegistration.get(params.id)
    if(courseSessionPerRegistration.attended)
      courseSessionPerRegistration.attended = false
    else
      courseSessionPerRegistration.attended = true

    response.addHeader("Access-Control-Allow-Origin","*")
    response.addHeader("Content-Type","	application/json;charset=UTF-8")
    render([attended:courseSessionPerRegistration.attended] as JSON)
  }

  def createCertificate = {
    def studentsGroup = StudentsGroup.get(params.id)
    def studentsGroupReport = []
    studentsGroup.students.each{ student ->
      def n = new Expando()
      n.email = student.email
      studentsGroupReport << n
    }
    params._format = "PDF"
    chain(controller:"jasper",action:"index",model:[data:studentsGroup.students],params:params)
  }
}
