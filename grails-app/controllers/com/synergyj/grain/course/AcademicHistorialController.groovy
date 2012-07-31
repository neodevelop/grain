package com.synergyj.grain.course

import com.synergyj.grain.auth.User

class AcademicHistorialController {

  def springSecurityService

  def my = {
    // Obtenemos al usuario actual
    User user = springSecurityService.currentUser
    
  }
}
