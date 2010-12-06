<%@ page import="com.synergyj.grain.ui.MenuOption" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <title><g:message code="menuOption.list" default="MenuOption List"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menuOption.list', default: 'MenuOption List')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="menuOption.new" default="New MenuOption"/></g:link></span>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="menuOption.id"/>

        <th><g:message code="menuOption.item" default="Item"/></th>

        <g:sortableColumn property="order" title="Order" titleKey="menuOption.order"/>

        <g:sortableColumn property="permissions" title="Permissions" titleKey="menuOption.permissions"/>

        <th><g:message code="menuOption.menu" default="Menu"/></th>

      </tr>
      </thead>
      <tbody>
      <g:each in="${menuOptionInstanceList}" status="i" var="menuOptionInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${menuOptionInstance.id}">${fieldValue(bean: menuOptionInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: menuOptionInstance, field: "item")}</td>

          <td>${fieldValue(bean: menuOptionInstance, field: "order")}</td>

          <td>${fieldValue(bean: menuOptionInstance, field: "permissions")}</td>

          <td>${fieldValue(bean: menuOptionInstance, field: "menu")}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${menuOptionInstanceTotal}"/>
  </div>
</div>
</body>
</html>
