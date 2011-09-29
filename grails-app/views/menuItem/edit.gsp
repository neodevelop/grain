<%@ page import="com.synergyj.grain.ui.MenuItem" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <title><g:message code="menuItem.edit" default="Edit MenuItem"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menuItem.edit', default: 'Edit MenuItem')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="menuItem.list" default="MenuItem List"/></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="menuItem.new" default="New MenuItem"/></g:link></span>
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
  <g:form method="post">
    <g:hiddenField name="id" value="${menuItemInstance?.id}"/>
    <g:hiddenField name="version" value="${menuItemInstance?.version}"/>
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

        <tr class="prop">
          <td valign="top" class="name">
            <label for="linkParams"><g:message code="menuItem.linkParams" default="Link Params"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuItemInstance, field: 'linkParams', 'errors')}">

            <ul>
              <g:each in="${menuItemInstance?.linkParams}" var="linkParamInstance">
                <li><g:link controller="linkParam" action="show" id="${linkParamInstance.id}">${linkParamInstance?.encodeAsHTML()}</g:link></li>
              </g:each>
            </ul>
            <g:link controller="linkParam" params="['menuItem.id': menuItemInstance?.id]" action="create"><g:message code="linkParam.new" default="New LinkParam"/></g:link>

          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
