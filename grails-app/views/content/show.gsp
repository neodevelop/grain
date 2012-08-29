<%@ page import="com.synergyj.grain.content.Content" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="content.show" default="Show Content"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'content.show', default: 'Show Content')}"/>
  
</head>
<body>

  <g:link class="btn" action="list"><g:message code="content.list" default="Content List"/></g:link>
  <g:link class="btn" action="create"><g:message code="content.new" default="New Content"/></g:link>

<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:form>
    <g:hiddenField name="id" value="${contentInstance?.id}"/>
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.id" default="Id"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.title" default="Title"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "title")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.body" default="Body"/>:</td>

          <td valign="top" class="value">${contentInstance.body}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.language" default="Language"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "language")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.key" default="Key"/>:</td>

          <td valign="top" class="value">${fieldValue(bean: contentInstance, field: "key")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.author" default="Author"/>:</td>

          <td valign="top" class="value"><g:link controller="user" action="show" id="${contentInstance?.author?.id}">${contentInstance?.author?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.type" default="Type"/>:</td>

          <td valign="top" class="value">${contentInstance?.type?.encodeAsHTML()}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.lastUpdated" default="Last Updated"/>:</td>

          <td valign="top" class="value"><g:formatDate date="${contentInstance?.lastUpdated}"/></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="content.dateCreated" default="Date Created"/>:</td>

          <td valign="top" class="value"><g:formatDate date="${contentInstance?.dateCreated}"/></td>

        </tr>

        </tbody>
      </table>
    </div>

    <g:actionSubmit class="btn" action="edit" value="${message(code: 'edit', 'default': 'Edit')}"/>
    <g:actionSubmit class="btn" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/>

  </g:form>
</div>
</body>
</html>
