package com.synergyj.grain.course

import com.synergyj.grain.auth.RegistrationCodeForScheduledCourse

class LandingService {

  static transactional = true

  def obtainRegistrationCode(String email, Long scheduledCourseId) {
    // Buscamos si el usuario ya se registró previamente
    def registrationCode = RegistrationCodeForScheduledCourse.findByUsernameAndScheduledCourseId(email, scheduledCourseId)

    // Si no existe un código de registro lo generamos
    if (!registrationCode) {
      registrationCode = RegistrationCodeForScheduledCourse.create(email, scheduledCourseId)
    }

    registrationCode
  }
}