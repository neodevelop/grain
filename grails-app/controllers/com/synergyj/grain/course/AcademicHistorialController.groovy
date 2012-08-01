package com.synergyj.grain.course

import com.synergyj.grain.auth.User
import com.synergyj.grain.auth.RegistrationCodeForScheduledCourse

class AcademicHistorialController {

  def springSecurityService

  def my = {
    // Obtenemos al usuario actual
    User user = springSecurityService.currentUser
    // Obtenemos los registros de este usauario
    def registrationsForThisUser = Registration.findAllByStudent(user,[sort:"id", order:"desc"])
    // Obtenemos los códigos obtenidos de la landing page
    def registrationsCodes = RegistrationCodeForScheduledCourse.findAllByUsername(user.email,[sort:"dateCreated", order:"desc",max:5])
    [registrationsForThisUser:registrationsForThisUser,registrationsCodes:registrationsCodes]
  }
}
