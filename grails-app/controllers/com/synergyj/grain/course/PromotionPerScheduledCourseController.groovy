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

import grails.converters.JSON

class PromotionPerScheduledCourseController {

  def scaffold = PromotionPerScheduledCourse

  def checkCouponToRedeem = {
    def promotionPerScheduledCourse = PromotionPerScheduledCourse.withCriteria(uniqueResult: true) {
      eq('id', params.long('id'))
      join('promotion')
    }
    def model = [isValid: false,message:message(code: 'promotion.coupon.fail',args: ['Código incorrecto'])]
    if (promotionPerScheduledCourse.promotion.promotionKey == params?.coupon){
      model.isValid = true
      model.message = message(code: 'promotion.coupon.ok')
    }
    render model as JSON
  }

  def showForRegistration = {
    def criteria = PromotionPerScheduledCourse.createCriteria()
    def promotionsForScheduledCourse = criteria.list {
      scheduledCourse{
        eq "id",params.long('scheduledCourseId')
      }
    }
    def registration = Registration.findById(params.id,[fetch:[promotions:"eager"]])
    render template: "/promotionPerScheduledCourse/showForRegistration",
           model: [
             promotionsForScheduledCourse:promotionsForScheduledCourse,
             registration:registration
           ]
  }
}
