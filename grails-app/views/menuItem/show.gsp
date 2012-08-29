<%@ page import="com.synergyj.grain.ui.MenuItem" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="menuItem.show" default="Show MenuItem"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menuItem.show', default: 'Show MenuItem')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="list" action="list"><g:message code="menuItem.list" default="MenuItem List"/></g:link>
  <g:link class="create" action="create"><g:message code="menuItem.new" default="New MenuItem"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:form>
    <g:hiddenField name="id" value="${menuItemInstance?.id}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuItem.id" default="Id"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: menuItemInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuItem.labelCode" default="Label Code"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: menuItemInstance, field: "labelCode")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuItem.type" default="Type"/>:</td>

          <td valign="top" class="value">${menuItemInstance?.type?.encodeAsHTML()}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuItem.permissions" default="Permissions"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: menuItemInstance, field: "permissions")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menuItem.linkParams" default="Link Params"/>:</td>

          <td valign="top" style="text-align: left;" class="value">
            <ul>
              <g:each in="${menuItemInstance?.linkParams}" var="linkParamInstance">
                <li><g:link controller="linkParam" action="show" id="${linkParamInstance.id}">${linkParamInstance.encodeAsHTML()}</g:link></li>
              </g:each>
            </ul>
          </td>

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
