<%@ page import="com.synergyj.grain.course.Expense" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title><g:message code="expense.edit" default="Edit Expense"/></title>
</head>

<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  </span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="expense.list"
                                                                         default="Expense List"/></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="expense.new"
                                                                             default="New Expense"/></g:link></span>
</div>

<div class="body">
  <h1><g:message code="expense.edit" default="Edit Expense"/></h1>
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}"
                                    default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:hasErrors bean="${expenseInstance}">
    <div class="errors">
      <g:renderErrors bean="${expenseInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form method="post">
    <g:hiddenField name="id" value="${expenseInstance?.id}"/>
    <g:hiddenField name="version" value="${expenseInstance?.version}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="amount"><g:message code="expense.amount" default="Amount"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'amount', 'errors')}">
            <g:textField name="amount" value="${fieldValue(bean: expenseInstance, field: 'amount')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="description"><g:message code="expense.description" default="Description"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'description', 'errors')}">
            <g:textField name="description" value="${fieldValue(bean: expenseInstance, field: 'description')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="expenseCategory"><g:message code="expense.expenseCategory" default="Expense Category"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'expenseCategory', 'errors')}">
            <g:select name="expenseCategory" from="${com.synergyj.grain.course.ExpenseCategory?.values()}"
                      value="${expenseInstance?.expenseCategory}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="expenseTime"><g:message code="expense.expenseTime" default="Expense Time"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'expenseTime', 'errors')}">
            <g:datePicker name="expenseTime" value="${expenseInstance?.expenseTime}"/>

          </td>
        </tr>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" action="update"
                                           value="${message(code: 'update', 'default': 'Update')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete"
                                           value="${message(code: 'delete', 'default': 'Delete')}"
                                           onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
