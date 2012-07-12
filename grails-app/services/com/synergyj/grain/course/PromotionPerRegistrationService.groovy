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

class PromotionPerRegistrationService {

  static transactional = true

  def applyPromotionsToRegistration(Long registrationId, promotionIds) {
    // Obtenemos el registro a modificar
    def registration = Registration.findById(registrationId,[fetch:[promotions:"eager"]])
    // Buscamos los objetos de tipo PromotionPerScheduledCourse
    def promotionsPerScheduledCourseSelected = PromotionPerScheduledCourse.getAll(promotionIds)
    // Obtenemos los promotions y ejecutamos findAll en ellos, algo en el GORM no permite hacerlo directo
    def promotionsToRemove = registration.promotions.findAll { it }
    // Iteramos los objetos
    promotionsToRemove.each { promotion ->
      // Lo quitamos del maestro
      registration.removeFromPromotions promotion
      // Borramos el detalle
      promotion.delete()
    }
    // Iteramos las promociones seleccionadas
    promotionsPerScheduledCourseSelected.each { promotionPerScheduledCourse ->
      // Creamos un nuevo promotion para el registro
      def promotionPerRegistration = new PromotionPerRegistration(promotion: promotionPerScheduledCourse.promotion)
      // Lo agregamos al maestro
      registration.addToPromotions(promotionPerRegistration)
    }
    // Guardamos el maestro
    registration.save()
  }
}
