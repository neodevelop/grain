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

@Secured(["hasRole('ROLE_ADMIN')"])
class StudentsGroupController {
  def create = {
    def scheduledCourse =  ScheduledCourse.get(params.id)
    def months = ['ENERO','FEBRERO','MARZO','ABRIL','MAYO','JUNIO','JULIO','AGOSTO','SEPTIEMBRE','OCTUBRE','NOVIEMBRE','DICIEMBRE']
    def key = "${scheduledCourse.course.courseKey}-${months[scheduledCourse.beginDate.month - 1]}"
    if(!scheduledCourse.studentsGroup){
      scheduledCourse.studentsGroup = new StudentsGroup(scheduledCourse: scheduledCourse,key: key)
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
    [studentsGroup:studentsGroup,studentsInGroup:studentsInGroup,studentsNoGroup:studentsNoGroup ]
  }

  def addStudent = {
    def studentsGroup = StudentsGroup.get(params.long("studentsGroupId"))
    def user = User.get(params.id)
    studentsGroup.addToStudents(user)
  }

  def removeStudent = {
    println "Remover estudiante ${params.id} al grupo ${params.studentsGroupId}"
    def studentsGroup = StudentsGroup.get(params.long("studentsGroupId"))
    def user = User.get(params.id)
    studentsGroup.removeFromStudents(user)
  }
}
