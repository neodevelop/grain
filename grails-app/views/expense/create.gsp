<%@ page import="com.synergyj.grain.course.Expense" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="expense.create" default="Create Expense"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'expense.create', default: 'Create Expense')}"/>
</head>

<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  </span>
  <span class="menuButton"><g:link class="btn" action="list"><g:message code="expense.list"
                                                                         default="Expense List"/></g:link></span>
</div>

<div class="body">
  <g:render template="/common/errors" model="[instance:expenseInstance]"/>
  <g:form action="save" method="post">
    <g:render template="form" model="[expenseInstance:expenseInstance]"/>
    <div class="form-actions">
      <span class="button">
        <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'create', 'default': 'Create')}"/>
      </span>
    </div>
  </g:form>
</div>
</body>
</html>
