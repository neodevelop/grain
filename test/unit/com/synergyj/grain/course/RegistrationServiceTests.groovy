package com.synergyj.grain.course

import grails.test.*
import com.synergyj.grain.auth.User
import com.synergyj.grain.event.NotificationService

class RegistrationServiceTests extends GrailsUnitTestCase {

  void testAddUserToScheduledCourse() {
    // Intanciamos el servicio a probar
    def registrationService = new RegistrationService()
    //Creamos la instancia Mock del usuario
    def existingUser = new User(email: "something@server.com", password: "secret")
    mockDomain(User,[existingUser])
    // Creamos la instancia Mock del Curso al que queremos registrar al usuario
    def scheduledCourse = new ScheduledCourse(id:1L)
    mockDomain(ScheduledCourse,[scheduledCourse])
    // Creamos el mock para los objetos de Registro
    mockDomain(Registration)
    // Creamos el colaborador del servicio prinicipal
    def notificationServiceMock = mockFor(NotificationService)
    notificationServiceMock.demand.sendCourseRegistration(1..1) { Long id -> return 0 }
    // Asignamos el colaborador al servicio principal
    registrationService.notificationService = notificationServiceMock.createMock()
    // Probamos el servicio
    def registration = registrationService.addUserToScheduledCourse(existingUser,1L)
    // Corroboramos que se ha creado el registro
    assertNotNull(registration)
  }
}
