<%@ page import="com.synergyj.grain.ui.Menu" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="menu.edit" default="Edit Menu"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menu.edit', default: 'Edit Menu')}"/>
</head>
<body>
<div class="nav">
  <a class="btn" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="btn" action="list"><g:message code="menu.list" default="Menu List"/></g:link>
  <g:link class="btn btn-primary" action="create"><g:message code="menu.new" default="New Menu"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:hasErrors bean="${menuInstance}">
    <div class="errors">
      <g:renderErrors bean="${menuInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form method="post">
    <g:hiddenField name="id" value="${menuInstance?.id}"/>
    <g:hiddenField name="version" value="${menuInstance?.version}"/>
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

        <tr class="prop">
          <td valign="top" class="name">
            <label for="items"><g:message code="menu.items" default="Items"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: menuInstance, field: 'items', 'errors')}">

            <ul>
              <g:each in="${menuInstance?.items}" var="menuOptionInstance">
                <li><g:link controller="menuOption" action="show" id="${menuOptionInstance.id}">${menuOptionInstance?.encodeAsHTML()}</g:link></li>
              </g:each>
            </ul>
            <g:link controller="menuOption" params="['menu.id': menuInstance?.id]" action="create"><g:message code="menuOption.new" default="New MenuOption"/></g:link>

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
