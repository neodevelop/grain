<%@ page import="com.synergyj.grain.ui.LinkParam" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="linkParam.show" default="Show LinkParam"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'linkParam.show', default: 'Show LinkParam')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="btn" action="list"><g:message code="linkParam.list" default="LinkParam List"/></g:link>
  <g:link class="create" action="create"><g:message code="linkParam.new" default="New LinkParam"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:form>
    <g:hiddenField name="id" value="${linkParamInstance?.id}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="linkParam.id" default="Id"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: linkParamInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="linkParam.name" default="Name"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: linkParamInstance, field: "name")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="linkParam.value" default="Value"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: linkParamInstance, field: "value")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="linkParam.menuItem" default="Menu Item"/>:</td>

          <td valign="top" class="value"><g:link controller="menuItem" action="show" id="${linkParamInstance?.menuItem?.id}">${linkParamInstance?.menuItem?.encodeAsHTML()}</g:link></td>

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
