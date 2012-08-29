<%@ page import="com.synergyj.grain.ui.Menu" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="menu.create" default="Create Menu"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menu.create', default: 'Create Menu')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="menu.list" default="Menu List"/></g:link></span>
</div>
<div class="body">
  <h1><g:message code="menu.create" default="Create Menu"/></h1>
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:hasErrors bean="${menuInstance}">
    <div class="errors">
      <g:renderErrors bean="${menuInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="name"><g:message code="menu.name" default="Name"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuInstance, field: 'name', 'errors')}">
            <g:textField name="name" maxlength="100" value="${fieldValue(bean: menuInstance, field: 'name')}"/>

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
