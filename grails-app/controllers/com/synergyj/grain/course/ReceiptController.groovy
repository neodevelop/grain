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

  def showImage = {
    def receipt = Receipt.get(params.id)
    response.contentType = 'image/jpeg'
    response.outputStream << receipt.image
    response.outputStream.flush()
    return;
  }
  def approve = {
    def receipt = Receipt.get(params.id)
    receipt.receiptStatus = ReceiptStatus.APROVED
    receipt.payment.paymentStatus = PaymentStatus.PAYED
    registrationService.checkIsPayed(receipt.payment.registration.id)
    render """
      <img src="${createLinkTo(dir:'themes/wb/icon',file:'valid-green.png')}" width="24" height="24" />
    """
  }

  def delete = {
    def receipt = Receipt.get(params.id)
    receipt.delete()
    render ""
  }
}
