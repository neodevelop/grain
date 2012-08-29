<%@ page import="com.synergyj.grain.ui.MenuItem" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="menuItem.create" default="Create MenuItem"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menuItem.create', default: 'Create MenuItem')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="menuItem.list" default="MenuItem List"/></g:link></span>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:hasErrors bean="${menuItemInstance}">
    <div class="errors">
      <g:renderErrors bean="${menuItemInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="labelCode"><g:message code="menuItem.labelCode" default="Label Code"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuItemInstance, field: 'labelCode', 'errors')}">
            <g:textField name="labelCode" maxlength="100" value="${fieldValue(bean: menuItemInstance, field: 'labelCode')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="type"><g:message code="menuItem.type" default="Type"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuItemInstance, field: 'type', 'errors')}">
            <g:select name="type" from="${com.synergyj.grain.ui.LinkType?.values()}" value="${menuItemInstance?.type}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="permissions"><g:message code="menuItem.permissions" default="Permissions"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuItemInstance, field: 'permissions', 'errors')}">
            <g:textField name="permissions" maxlength="200" value="${fieldValue(bean: menuItemInstance, field: 'permissions')}"/>

          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="form-actions">
      <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
