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

class ReceiptController {

  def registrationService
  def dineroMailService
  def s3AssetService
  def receiptService

  def approve = {
    receiptService.approveReceiptAndCheckRegistration(params.long('id'))
    render(contentType:"text/json") {
      message = "Recibo aprobado"
      status = 200
	  }
  }

  def approveDineroMail = {
    try {
      if (dineroMailService.verifyPayment(params.long('id'))) {
        registrationService.checkIsPayed(params.long('registrationId'))
        render(contentType:"text/json") {
          message = "Pago realizado"
          status = 200
	      }
      } else {
        render(contentType:"text/json") {
          message = "Pago NO realizado"
          status = 400
	      }
      }
    } catch (RuntimeException e) {
      log.error(e.message)
      render(contentType:"text/json") {
        message = "Error al obtener la información del pago"
        status = 400
	    }
    }

  }

  def delete = {
    receiptService.deleteThisReceipt(params.long('id'))
    render(contentType:"text/json") {
      message = "Recibo eliminado"
      status = 200
	  }
  }
}
