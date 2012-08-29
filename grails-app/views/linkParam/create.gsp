<%@ page import="com.synergyj.grain.ui.LinkParam" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="linkParam.create" default="Create LinkParam"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'linkParam.create', default: 'Create LinkParam')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="btn" action="list"><g:message code="linkParam.list" default="LinkParam List"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:hasErrors bean="${linkParamInstance}">
    <div class="errors">
      <g:renderErrors bean="${linkParamInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="name"><g:message code="linkParam.name" default="Name"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: linkParamInstance, field: 'name', 'errors')}">
            <g:textField name="name" maxlength="100" value="${fieldValue(bean: linkParamInstance, field: 'name')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="value"><g:message code="linkParam.value" default="Value"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: linkParamInstance, field: 'value', 'errors')}">
            <g:textField name="value" maxlength="100" value="${fieldValue(bean: linkParamInstance, field: 'value')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="menuItem"><g:message code="linkParam.menuItem" default="Menu Item"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: linkParamInstance, field: 'menuItem', 'errors')}">
            <g:select name="menuItem.id" from="${com.synergyj.grain.ui.MenuItem.list()}" optionKey="id" value="${linkParamInstance?.menuItem?.id}"/>

          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="form-actions">
      <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'create', 'default': 'Create')}"/>
    </div>
  </g:form>
</div>
</body>
</html>
