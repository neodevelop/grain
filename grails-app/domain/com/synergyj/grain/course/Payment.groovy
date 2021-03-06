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

class Payment implements Comparable,Serializable{

  transient private static final long serialVersionUID = -1L

  BigDecimal amount
  BigDecimal commission = 0
  String transactionId
  Date paymentDate
  String description
  PaymentStatus paymentStatus
  KindOfPayment kindOfPayment

  Date dateCreated
	Date lastUpdated

  static belongsTo = [registration:Registration]
  static hasMany = [receipts:ReceiptAWS]

  static constraints = {
    amount nullable:false
    commission nullable:true
    transactionId unique: true, maxSize: 20
    paymentDate nullable: true
    dateCreated(display:false)
    lastUpdated(display:false)
  }

  int compareTo(obj) {
    dateCreated.compareTo(obj.dateCreated)
  }
}
