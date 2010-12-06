<%@ page import="com.synergyj.grain.ui.Menu" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <title><g:message code="menu.edit" default="Edit Menu"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menu.edit', default: 'Edit Menu')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="menu.list" default="Menu List"/></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="menu.new" default="New Menu"/></g:link></span>
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
    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
