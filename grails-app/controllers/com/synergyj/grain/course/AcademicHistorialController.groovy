package com.synergyj.grain.course

import com.synergyj.grain.auth.User
import com.synergyj.grain.auth.RegistrationCodeForScheduledCourse

class AcademicHistorialController {

  def springSecurityService

  def my = {
    // Obtenemos al usuario actual
    User user = springSecurityService.currentUser
    // Obtenemos los registros que ha hecho
    def registrationsNoConfirmed = RegistrationCodeForScheduledCourse.findAllByUsername(user.email,[sort:"dateCreated", order:"desc"])
    // Obtenemos los registros de este usauario
    def registrationsForThisUser = Registration.findAllByStudent(user,[sort:"id", order:"desc"])
    [registrationsNoConfirmed:registrationsNoConfirmed,registrationsForThisUser:registrationsForThisUser]
  }
}
