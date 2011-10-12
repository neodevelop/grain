package com.synergyj.grain.course

class Expense {

  BigDecimal amount
  String description
  ExpenseCategory expenseCategory
  Date expenseTime
  Date dateCreated
  Date lastUpdated

  static belongsTo = { scheduledCourse: ScheduledCourse}

  static constraints = {
    dateCreated(display: false)
    lastUpdated(display: false)
  }
}
