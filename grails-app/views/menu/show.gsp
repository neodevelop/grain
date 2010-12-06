<%@ page import="com.synergyj.grain.ui.Menu" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <title><g:message code="menu.show" default="Show Menu"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'menu.show', default: 'Show Menu')}"/>
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
    <div class="buttons">
      <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
