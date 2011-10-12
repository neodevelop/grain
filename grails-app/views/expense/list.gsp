<%@ page import="com.synergyj.grain.course.Expense" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="main"/>
  <title><g:message code="expense.list" default="Expense List"/></title>
</head>

<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  </span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="expense.new"
                                                                             default="New Expense"/></g:link></span>
</div>

<div class="body">
  <h1><g:message code="expense.list" default="Expense List"/></h1>
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}"
                                    default="${flash.defaultMessage}"/></div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="expense.id"/>

        <g:sortableColumn property="dateCreated" title="Date Created" titleKey="expense.dateCreated"/>

        <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="expense.lastUpdated"/>

        <g:sortableColumn property="amount" title="Amount" titleKey="expense.amount"/>

        <g:sortableColumn property="description" title="Description" titleKey="expense.description"/>

        <g:sortableColumn property="expenseCategory" title="Expense Category" titleKey="expense.expenseCategory"/>

      </tr>
      </thead>
      <tbody>
      <g:each in="${expenseInstanceList}" status="i" var="expenseInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show"
                      id="${expenseInstance.id}">${fieldValue(bean: expenseInstance, field: "id")}</g:link></td>

          <td><g:formatDate date="${expenseInstance.dateCreated}"/></td>

          <td><g:formatDate date="${expenseInstance.lastUpdated}"/></td>

          <td><g:formatNumber number="${expenseInstance.amount}"/></td>

          <td>${fieldValue(bean: expenseInstance, field: "description")}</td>

          <td>${fieldValue(bean: expenseInstance, field: "expenseCategory")}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>

  <div class="paginateButtons">
    <g:paginate total="${expenseInstanceTotal}"/>
  </div>
</div>
</body>
</html>
