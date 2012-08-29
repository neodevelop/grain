<%@ page import="com.synergyj.grain.ui.MenuOption" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="menuOption.edit" default="Edit MenuOption"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menuOption.edit', default: 'Edit MenuOption')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="list" action="list"><g:message code="menuOption.list" default="MenuOption List"/></g:link>
  <g:link class="create" action="create"><g:message code="menuOption.new" default="New MenuOption"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:hasErrors bean="${menuOptionInstance}">
    <div class="errors">
      <g:renderErrors bean="${menuOptionInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form method="post">
    <g:hiddenField name="id" value="${menuOptionInstance?.id}"/>
    <g:hiddenField name="version" value="${menuOptionInstance?.version}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="item"><g:message code="menuOption.item" default="Item"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuOptionInstance, field: 'item', 'errors')}">
            <g:select name="item.id" from="${com.synergyj.grain.ui.MenuItem.list()}" optionKey="id" value="${menuOptionInstance?.item?.id}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="order"><g:message code="menuOption.order" default="Order"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuOptionInstance, field: 'order', 'errors')}">
            <g:textField name="order" value="${fieldValue(bean: menuOptionInstance, field: 'order')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="permissions"><g:message code="menuOption.permissions" default="Permissions"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuOptionInstance, field: 'permissions', 'errors')}">
            <g:textField name="permissions" maxlength="200" value="${fieldValue(bean: menuOptionInstance, field: 'permissions')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="menu"><g:message code="menuOption.menu" default="Menu"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuOptionInstance, field: 'menu', 'errors')}">
            <g:select name="menu.id" from="${com.synergyj.grain.ui.Menu.list()}" optionKey="id" value="${menuOptionInstance?.menu?.id}"/>

          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="form-actions">
      <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'update', 'default': 'Update')}"/>
      <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/>
    </div>
  </g:form>
</div>
</body>
</html>
