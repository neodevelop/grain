<%@ page import="com.synergyj.grain.course.Expense" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="expense.show" default="Show Expense"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'expense.show', default: 'Show Expense')}"/>
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
  <g:form>
    <g:hiddenField name="id" value="${expenseInstance?.id}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="expense.id" default="Id"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="expense.dateCreated" default="Date Created"/>:</td>

          <td valign="top" class="value"><g:formatDate date="${expenseInstance?.dateCreated}"/></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="expense.lastUpdated" default="Last Updated"/>:</td>

          <td valign="top" class="value"><g:formatDate date="${expenseInstance?.lastUpdated}"/></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="expense.amount" default="Amount"/>:</td>

          <td valign="top" class="value"><g:formatNumber number="${expenseInstance?.amount}"/></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="expense.description" default="Description"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: expenseInstance, field: "description")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="expense.expenseCategory" default="Expense Category"/>:</td>

          <td valign="top" class="value">${expenseInstance?.expenseCategory?.encodeAsHTML()}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="expense.expenseTime" default="Expense Time"/>:</td>

          <td valign="top" class="value"><g:formatDate date="${expenseInstance?.expenseTime}"/></td>

        </tr>

        </tbody>
      </table>
    </div>

    <div class="buttons">
      <span class="button"><g:actionSubmit class="edit" action="edit"
                                           value="${message(code: 'edit', 'default': 'Edit')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete"
                                           value="${message(code: 'delete', 'default': 'Delete')}"
                                           onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
