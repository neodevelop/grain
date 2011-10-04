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
import com.synergyj.grain.course.Payment

class IPNController {

  def dineroMailService

  def index = {
    // Si viene el parámetro de notificación entonces lo tratamos
    if (params.NOTIFICACION) {
      // Parseamos el XML contenido en dicho parámetro
      def rootNode = XML.parse(params.NOTIFICACION)
      // Si el tipo de notificaciones es el que pide DM
      if (rootNode.TIPONOTIFICACION.text() == '1') {
        // Recorremos las operaciones notificadas
        rootNode.OPERACIONES.OPERACION.each { op ->
          // Llamammos la verificación del pago con el ID de cada operacion
          dineroMailService.verifyPayment(0L,op.ID.text())
        }
      }
    } else {
      log.error("No hay notificaciones en DM")
    }
    render "ok"
  }
}
