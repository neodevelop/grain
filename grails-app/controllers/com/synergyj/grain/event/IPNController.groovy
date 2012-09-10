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
package com.synergyj.grain.event

import grails.converters.XML

class IPNController {

  def dineroMailService
  def notificationService
  def registrationService

  def index = {
    def toLowerParams = [:]
    // Convertimos las llaves de los parámetros a minúsculas
    params.each { key, value ->
      toLowerParams."${key.toLowerCase()}" = value
    }
    // Si viene el parámetro de notificación entonces lo tratamos
    if (toLowerParams.notificacion) {
      // Parseamos el XML contenido en dicho parámetro
      def rootNode = XML.parse(toLowerParams.notificacion)
      // Si el tipo de notificaciones es el que pide DM
      if (rootNode.tiponotificacion.text() == '1') {
        // Recorremos las operaciones notificadas
        rootNode.operaciones.operacion.each { op ->
          // Llamammos la verificación del pago con el ID de cada operacion
          // Y checamos si ya se hizo el pago
          if(dineroMailService.verifyPayment(0L, op.id.text())){
            // Checamos si ya pago el total del curso
            //registrationService.checkIsPayed()
            // Enviamos el correo de confirmación de pago
            notificationService.sendPaymentConfirmation(op.id.text())
          }
        }
      }
    } else {
      log.error("No hay notificaciones en DM")
      log.error(params.dump())
    }
    render "ok"
  }
}
