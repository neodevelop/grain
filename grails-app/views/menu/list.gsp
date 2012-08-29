<%@ page import="com.synergyj.grain.ui.Menu" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="menu.list" default="Menu List"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menu.list', default: 'Menu List')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="create" action="create"><g:message code="menu.new" default="New Menu"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="menu.id"/>

        <g:sortableColumn property="name" title="Name" titleKey="menu.name"/>

      </tr>
      </thead>
      <tbody>
      <g:each in="${menuInstanceList}" status="i" var="menuInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${menuInstance.id}">${fieldValue(bean: menuInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: menuInstance, field: "name")}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${menuInstanceTotal}"/>
  </div>
</div>
</body>
</html>
