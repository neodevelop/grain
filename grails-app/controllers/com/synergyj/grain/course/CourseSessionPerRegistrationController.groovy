package com.synergyj.grain.course

import com.synergyj.grain.auth.User

class CourseSessionPerRegistrationController {

  def springSecurityService

  def currentUser = {
    // Obtenermos el usuario actual
    User user = springSecurityService.currentUser
    def registrations = Registration.findAllByStudentAndRegistrationStatusInList(
      user,
      [
        RegistrationStatus.FINISHED,
        RegistrationStatus.INSCRIBED_AND_WITH_DEBTH_IN_GROUP,
        RegistrationStatus.INSCRIBED_AND_PAYED_IN_GROUP],
      [sort:"id", order:"desc"]
    )
    [registrations:registrations]
  }
}
