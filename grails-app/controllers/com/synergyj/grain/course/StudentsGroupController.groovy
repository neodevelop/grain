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
import org.codehaus.groovy.grails.plugins.jasper.JasperExportFormat
import org.codehaus.groovy.grails.plugins.jasper.JasperReportDef
import java.text.SimpleDateFormat
import org.hibernate.FetchMode as FM

@Secured(["hasRole('ROLE_ADMIN')"])
class StudentsGroupController {

  def jasperService

  def show = {
    // Obtenemos el grupo de estudiantes
    def scheduledCourse = ScheduledCourse.get(params.id)
    // Buscamos los registros al curso calendarizado
    def criteria = Registration.createCriteria()
    def registrations = criteria.listDistinct {
      eq 'scheduledCourse',scheduledCourse
      join "student"
      fetchMode "promotions", FM.EAGER
      fetchMode "payments", FM.EAGER
    }
    // Obtenemos los usuarios que SI están en el grupo
    def registrationsInGroup = registrations.findAll { registration ->
      registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_PAYED_IN_GROUP || registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH_IN_GROUP || registration.registrationStatus == RegistrationStatus.FINISHED
    }
    // Obtenemos los registros que NO están en un grupo
    def registrationsNoGroup = registrations.findAll { registration ->
      registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH  || registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_PAYED || registration.registrationStatus == RegistrationStatus.CANCELLED
    }

    [scheduledCourse: scheduledCourse, registrationsInGroup: registrationsInGroup, registrationsNoGroup: registrationsNoGroup]
  }

  def addStudent = {
    def registration = Registration.get(params.id)
    if(registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH)
      registration.registrationStatus = RegistrationStatus.INSCRIBED_AND_WITH_DEBTH_IN_GROUP
    if(registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_PAYED)
      registration.registrationStatus = RegistrationStatus.INSCRIBED_AND_PAYED_IN_GROUP
  }

  def removeStudent = {
    def registration = Registration.get(params.id)
    if (registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH_IN_GROUP)
      registration.registrationStatus = RegistrationStatus.INSCRIBED_AND_WITH_DEBTH
    if (registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_PAYED_IN_GROUP)
      registration.registrationStatus = RegistrationStatus.INSCRIBED_AND_PAYED
  }

  def attendance = {
    // Obtenemos el curso calendarizado
    def scheduledCourse = ScheduledCourse.get(params.id)
    // Obtenemos las sesiones del curso calendarizado
    def scheduledCourseSessions = scheduledCourse.courseSessions
    // Iteramos a los alumnos para ver si tienen esas sesiones
    scheduledCourse.registrations.each { registration ->
      if (registration.registrationStatus == RegistrationStatus.FINISHED || registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_PAYED_IN_GROUP || registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH_IN_GROUP) {
        if (!registration.courseSessions.size()) {
          // Iteramos las sesiones del curso calendarizado
          scheduledCourseSessions.each { scheduledCourseSession ->
            // Las replicamos a cada alumno
            def courseSessionPerRegistration = new CourseSessionPerRegistration(
                registration: registration,
                courseSession: scheduledCourseSession
            )
            // Agregamos la sesión de curso calendarizado al estudiante
            registration.addToCourseSessions(courseSessionPerRegistration)
          }
        }
      }else{
        if(registration?.courseSessions?.size()){
          // Borramos las sesiones de este registro para este curso
          CourseSessionPerRegistration.executeUpdate("delete CourseSessionPerRegistration cpr where cpr.registration = :registration",[registration:registration])
        }
      }
    }
    [scheduledCourse: scheduledCourse]
  }

  def checkAttendance = {
    def courseSessionPerRegistration = CourseSessionPerRegistration.get(params.id)
    if (courseSessionPerRegistration.attended)
      courseSessionPerRegistration.attended = false
    else
      courseSessionPerRegistration.attended = true

    response.addHeader("Access-Control-Allow-Origin", "*")
    response.addHeader("Content-Type", "	application/json;charset=UTF-8")
    render([attended: courseSessionPerRegistration.attended] as JSON)
  }

  def createCertificate = {
    // Obtenemos el grupo completo
    def scheduledCourse = ScheduledCourse.get(params.id)
    // Buscamos los registros para ese grupo
    def criteria = Registration.createCriteria()
    def registrations = criteria.list {
      eq "scheduledCourse", scheduledCourse
      eq "registrationStatus", RegistrationStatus.FINISHED
    }

    // Inicializamos la lista que se va al reporte
    def reportData = []
    // Iteramos a los estudiantes
    (registrations*.student).each { student ->
      // Creamos un objeto certificado
      def certificate = new Certificate()
      // Le ponemos nombre a su diploma
      certificate.fullName = "${student?.firstName} ${student?.lastName}"
      // Ponemos el nombre del curso
      certificate.courseName = "${scheduledCourse.course.name}"
      // Indicamos la duración del curso
      // TODO: Este debe venir del curso
      certificate.duration = "40"
      // Obtenemos la fecha de inicio
      def startDate = scheduledCourse.beginDate
      // Usamos un formateador para la primera parte de la fecha
      def locale = new Locale("es")
      def dateFormat = new SimpleDateFormat("dd 'de' MMMMM", locale)
      // La asignamos al valor del certificado
      certificate.dateRange = "Del ${dateFormat.format(startDate)} "
      // Cambiamos el formateador
      dateFormat = new SimpleDateFormat("'al' dd 'de' MMMMMM 'del' yyyy", locale)
      // Obtenemos la última sesion
      def lastSession = (scheduledCourse.courseSessions.max()).sessionStartTime
      // Concatenamos la fecha con el uso del formateador
      certificate.dateRange += "${dateFormat.format(lastSession)}"
      // Agregamos los instructores
      // TODO: Asignar instructores por curso
      certificate.mainInstructor = "Domingo Suárez Torres"
      certificate.secondaryInstructor = "José Juan Reyes Zuñiga"
      // Agregamos el objeto a la lista
      reportData << certificate
    }

    // Generamos la definición del reporte
    def reportDef = new JasperReportDef(
        name: 'certificates.jasper',
        fileFormat: JasperExportFormat.PDF_FORMAT,
        reportData: reportData,
        parameters: [:]
    )
    // Mandamos un nombre de archivo a la salida
    response.setHeader("Content-disposition", "attachment; filename=certificates.pdf")
    // Mandamos el reporte al response
    response.outputStream << jasperService.generateReport(reportDef).toByteArray()
  }

  @Secured(["hasRole('ROLE_USER')"])
  def certificate = {
    def registration = Registration.get(params.id)
    Certificate certificate = new Certificate()
    certificate.fullName = "${registration.student.firstName} ${registration.student.lastName}"
    certificate.courseName = "${registration.scheduledCourse.course.name}"
    certificate.email = "${registration.student.email}"
    certificate.duration = "${registration.scheduledCourse.durationInHours}"
    def startDate = registration.scheduledCourse.beginDate
    // Usamos un formateador para la primera parte de la fecha
    def locale = new Locale("es")
    def dateFormat = new SimpleDateFormat("dd 'de' MMMMM", locale)
    // La asignamos al valor del certificado
    certificate.dateRange = "Del ${dateFormat.format(startDate)} "
    // Cambiamos el formateador
    dateFormat = new SimpleDateFormat("'al' dd 'de' MMMMMM 'del' yyyy", locale)
    // Obtenemos la última sesion
    def lastSession = (registration.scheduledCourse.courseSessions.max()).sessionStartTime
    // Concatenamos la fecha con el uso del formateador
    certificate.dateRange += "${dateFormat.format(lastSession)}"
    certificate.mainInstructor = "Domingo Suárez Torres"
    certificate.secondaryInstructor = "José Juan Reyes Zuñiga"

    def reportData = []
    reportData << certificate

    // Generamos la definición del reporte
    def reportDef = new JasperReportDef(
        name: 'certificate_image.jasper', // La imagen tiene una rut absoluta
        fileFormat: JasperExportFormat.PDF_FORMAT,
        reportData: reportData,
        parameters: [:]
    )

    // Mandamos un nombre de archivo a la salida
    response.setHeader("Content-disposition", "attachment; filename=${registration.scheduledCourse.course.courseKey}-${registration.student.email}.pdf")
    // Mandamos el reporte al response
    response.outputStream << jasperService.generateReport(reportDef).toByteArray()
  }
}
