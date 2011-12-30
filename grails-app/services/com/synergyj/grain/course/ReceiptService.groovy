package com.synergyj.grain.course

class ReceiptService {

  def s3AssetService
  def registrationService

  static transactional = true

  def attachReceiptToPayment(Long paymentNumber, file) {
    // Obtenemos el pago al que le asignaremos el recibo
    def payment = Payment.get(paymentNumber)
    // Creamos el recibo
    def receipt = new ReceiptAWS(receiptStatus: ReceiptStatus.RECEIVED, payment: payment)
    // Establecemos propiedades
    receipt.title = "Receipt for ${payment.transactionId}"
    receipt.description = "Receipt for ${payment.amount}"
    // Creamos el espacio temporal del archivo
    def tmp = s3AssetService.getNewTmpLocalFile(file.contentType)
    // Transferimos el archivo
    file.transferTo(tmp)
    // Usamos el método del asset para crear un archivo nuevo
    receipt.newFile(tmp);
    // El tipo del archivo es...
    receipt.mimeType = file.contentType;
    // Subimos el archivo
    s3AssetService.put(receipt)
    // Cambiamos el status del pago
    payment.paymentStatus = PaymentStatus.PENDING
    // Creamos la relación
    payment.addToReceipts(receipt)
  }

  def approveReceiptAndCheckRegistration(Long receiptId) {
    def receipt = ReceiptAWS.get(receiptId)
    receipt.receiptStatus = ReceiptStatus.APROVED
    receipt.payment.paymentStatus = PaymentStatus.PAYED
    receipt.payment.paymentDate = new Date()
    registrationService.checkIsPayed(receipt.payment.registration.id)
  }

  def deleteThisReceipt(Long receiptId) {
    def receipt = ReceiptAWS.get(receiptId)
    s3AssetService.delete(receipt)
  }
}
