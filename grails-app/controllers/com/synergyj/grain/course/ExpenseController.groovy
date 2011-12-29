package com.synergyj.grain.course

import grails.converters.JSON

import grails.plugins.springsecurity.Secured

@Secured(["hasRole('ROLE_ADMIN')"])
class ExpenseController {

  def scaffold = true
  def expenseService

  def addToScheduledCourse = {
    def expense = expenseService.createExpenseForScheduledCourse(params.long('scheduledCourseId'),params)
    render expense as JSON
  }

}
