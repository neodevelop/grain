<%@ page import="com.synergyj.grain.ui.Menu" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="menu.show" default="Show Menu"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menu.show', default: 'Show Menu')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="btn" action="list"><g:message code="menu.list" default="Menu List"/></g:link>
  <g:link class="create" action="create"><g:message code="menu.new" default="New Menu"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:form>
    <g:hiddenField name="id" value="${menuInstance?.id}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menu.id" default="Id"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: menuInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menu.name" default="Name"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: menuInstance, field: "name")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="menu.items" default="Items"/>:</td>

          <td valign="top" style="text-align: left;" class="value">
            <ul>
              <g:each in="${menuInstance?.items}" var="menuOptionInstance">
                <li><g:link controller="menuOption" action="show" id="${menuOptionInstance.id}">${menuOptionInstance.encodeAsHTML()}</g:link></li>
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
