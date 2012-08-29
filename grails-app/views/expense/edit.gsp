<%@ page import="com.synergyj.grain.course.Expense" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="expense.edit" default="Edit Expense"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'expense.edit', default: 'Edit Expense')}"/>
</head>

<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  </span>
  <span class="menuButton"><g:link class="btn" action="list"><g:message code="expense.list"
                                                                         default="Expense List"/></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="expense.new"
                                                                             default="New Expense"/></g:link></span>
</div>

<div class="body">
  <g:render template="/common/errors" model="[instance:expenseInstance]"/>
  <g:form method="post">
    <g:hiddenField name="id" value="${expenseInstance?.id}"/>
    <g:hiddenField name="version" value="${expenseInstance?.version}"/>
    
    <g:render template="form" model="[expenseInstance:expenseInstance]"/>

    <div class="form-actions">
      <span class="button">
        <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'update', 'default': 'Update')}"/>
      </span>
      <span class="button">
        <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/>
      </span>
    </div>
  </g:form>
</div>
</body>
</html>
