<%@ page import="com.synergyj.grain.ui.MenuItem" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <title><g:message code="menuItem.list" default="MenuItem List"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menuItem.list', default: 'MenuItem List')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="menuItem.new" default="New MenuItem"/></g:link></span>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="menuItem.id"/>

        <g:sortableColumn property="labelCode" title="Label Code" titleKey="menuItem.labelCode"/>

        <g:sortableColumn property="type" title="Type" titleKey="menuItem.type"/>

        <g:sortableColumn property="permissions" title="Permissions" titleKey="menuItem.permissions"/>

      </tr>
      </thead>
      <tbody>
      <g:each in="${menuItemInstanceList}" status="i" var="menuItemInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${menuItemInstance.id}">${fieldValue(bean: menuItemInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: menuItemInstance, field: "labelCode")}</td>

          <td>${fieldValue(bean: menuItemInstance, field: "type")}</td>

          <td>${fieldValue(bean: menuItemInstance, field: "permissions")}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${menuItemInstanceTotal}"/>
  </div>
</div>
</body>
</html>
