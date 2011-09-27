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

import java.text.SimpleDateFormat
import grails.converters.JSON
import grails.plugins.springsecurity.Secured
import com.synergyj.grain.ScheduledCourseException

@Secured(["hasRole('ROLE_ADMIN')"])
class ScheduledCourseController {

  def courseSessionService

  def index = { redirect(action: "list", params: params) }

  def newSessionToCourse = {
    def scheduledCourseId = params.scheduledCourseId as Long
    def dateFormat = new SimpleDateFormat("dd/MM/yy HH:mm")
    def sessionStartTime = dateFormat.parse("${params.sessionStartTime} ${params.sessionHourStartTime}") as Date
    def courseSession = courseSessionService.createSession4ScheduledCourse(
        scheduledCourseId,
        sessionStartTime,
        params.int('duration'),
        params.long('courseSessionId')
    )
    render courseSession as JSON
  }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    params.fetch = [course:"eager"]
    def scheduledCourseInstanceList = ScheduledCourse.list(params)
    def hasPendingPayments = [:]
    scheduledCourseInstanceList.each { scheduledCourse ->
      if (scheduledCourse.scheduledCourseStatus != ScheduledCourseStatus.CANCELLED) {
        def criteria = Registration.createCriteria()
        def pendingPaymentRegistrations = criteria.count {
          eq 'scheduledCourse', scheduledCourse
          eq 'registrationStatus', RegistrationStatus.PENDING_PAYMENT
        }
        if(pendingPaymentRegistrations)
          hasPendingPayments."sc${scheduledCourse.id}" = pendingPaymentRegistrations
      }

    }
    [scheduledCourseInstanceList: scheduledCourseInstanceList, scheduledCourseInstanceTotal: ScheduledCourse.count(), hasPendingPayments:hasPendingPayments]
  }

  def create = {
    def scheduledCourseInstance = new ScheduledCourse()
    scheduledCourseInstance.properties = params
    return [scheduledCourseInstance: scheduledCourseInstance]
  }

  def save = {
    def scheduledCourseInstance = new ScheduledCourse(params)
    if (!scheduledCourseInstance.hasErrors() && scheduledCourseInstance.save(flush: true)) {
      try {
        def courseSession = courseSessionService.createSession4ScheduledCourse(scheduledCourseInstance.id, scheduledCourseInstance.beginDate)
      } catch (ScheduledCourseException e) {
        flash.defaultMessage = "Course session was not created"
        render(view: "create", model: [scheduledCourseInstance: scheduledCourseInstance])
      }
      flash.message = "scheduledCourse.created"
      flash.args = [scheduledCourseInstance.id]
      flash.defaultMessage = "ScheduledCourse ${scheduledCourseInstance.id} created"
      redirect(action: "show", id: scheduledCourseInstance.id)
    }
    else {
      render(view: "create", model: [scheduledCourseInstance: scheduledCourseInstance])
    }
  }

  def show = {
    def scheduledCourseInstance = ScheduledCourse.get(params.id)
    if (!scheduledCourseInstance) {
      flash.message = "scheduledCourse.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "ScheduledCourse not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [scheduledCourseInstance: scheduledCourseInstance]
    }
  }

  def edit = {
    def scheduledCourseInstance = ScheduledCourse.get(params.id)
    if (!scheduledCourseInstance) {
      flash.message = "scheduledCourse.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "ScheduledCourse not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [scheduledCourseInstance: scheduledCourseInstance]
    }
  }

  def update = {
    def scheduledCourseInstance = ScheduledCourse.get(params.id)
    println "Valor de base de datos:" + scheduledCourseInstance.costByModule
    println "Valor del formulario:" + params.costByModule
    if (scheduledCourseInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (scheduledCourseInstance.version > version) {

          scheduledCourseInstance.errors.rejectValue("version", "scheduledCourse.optimistic.locking.failure", "Another user has updated this ScheduledCourse while you were editing")
          render(view: "edit", model: [scheduledCourseInstance: scheduledCourseInstance])
          return
        }
      }
      scheduledCourseInstance.properties = params
      if (!scheduledCourseInstance.hasErrors() && scheduledCourseInstance.save()) {
        flash.message = "scheduledCourse.updated"
        flash.args = [params.id]
        flash.defaultMessage = "ScheduledCourse ${params.id} updated"
        redirect(action: "show", id: scheduledCourseInstance.id)
      }
      else {
        render(view: "edit", model: [scheduledCourseInstance: scheduledCourseInstance])
      }
    }
    else {
      flash.message = "scheduledCourse.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "ScheduledCourse not found with id ${params.id}"
      redirect(action: "edit", id: params.id)
    }
  }

  def delete = {
    def scheduledCourseInstance = ScheduledCourse.get(params.id)
    if (scheduledCourseInstance) {
      try {
        scheduledCourseInstance.delete()
        flash.message = "scheduledCourse.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "ScheduledCourse ${params.id} deleted"
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "scheduledCourse.not.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "ScheduledCourse ${params.id} could not be deleted"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "scheduledCourse.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "ScheduledCourse not found with id ${params.id}"
      redirect(action: "list")
    }
  }
}
