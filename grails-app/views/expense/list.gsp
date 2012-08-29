<%@ page import="com.synergyj.grain.course.Expense" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="expense.list" default="Expense List"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'expense.list', default: 'Expense List')}"/>
  <script type="text/javascript" language="javascript" src="${resource(dir: 'js', file: 'tables.js')}"></script>
  <script language="javascript">
    $(function() {
      $("div.list table").styleTable();
    });
  </script>
</head>

<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  </span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="expense.new"
                                                                             default="New Expense"/></g:link></span>
</div>

<div class="body">
  <div class="btn">
    <table cellpadding="5" cellspacing="0" border="0" width="100%">
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="expense.id"/>

        <g:sortableColumn property="expenseTime" title="Expense Time" titleKey="expense.expenseTime"/>

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

          <td><g:formatDate date="${expenseInstance.expenseTime}"/></td>

          <td>$ <g:formatNumber number="${expenseInstance.amount}" locale="MX" format="#,###.00"/></td>

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
