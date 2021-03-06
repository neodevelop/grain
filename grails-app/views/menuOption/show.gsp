<%@ page import="com.synergyj.grain.ui.MenuOption" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="menuOption.show" default="Show MenuOption"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menuOption.show', default: 'Show MenuOption')}"/>
</head>
<body>
<div class="nav">
  <a class="btn" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="btn" action="list"><g:message code="menuOption.list" default="MenuOption List"/></g:link>
  <g:link class="btn btn-primary" action="create"><g:message code="menuOption.new" default="New MenuOption"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:form>
    <g:hiddenField name="id" value="${menuOptionInstance?.id}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuOption.id" default="Id"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: menuOptionInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuOption.item" default="Item"/>:</td>

          <td valign="top" class="value"><g:link controller="menuItem" action="show" id="${menuOptionInstance?.item?.id}">${menuOptionInstance?.item?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuOption.order" default="Order"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: menuOptionInstance, field: "order")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuOption.permissions" default="Permissions"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: menuOptionInstance, field: "permissions")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuOption.menu" default="Menu"/>:</td>

          <td valign="top" class="value"><g:link controller="menu" action="show" id="${menuOptionInstance?.menu?.id}">${menuOptionInstance?.menu?.encodeAsHTML()}</g:link></td>

        </tr>

        </tbody>
      </table>
    </div>
    <div class="form-actions">
      <g:actionSubmit class="btn" action="edit" value="${message(code: 'edit', 'default': 'Edit')}"/>
      <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/>
    </div>
  </g:form>
</div>
</body>
</html>
