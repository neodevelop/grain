package com.synergyj.grain.course

class PaymentTagLib {
  static namespace = 'payment'

  def method = { attrs, body ->
    out << "^_^ Yes"
  }
}
