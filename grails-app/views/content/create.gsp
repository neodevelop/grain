<%@ page import="com.synergyj.grain.content.Content" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <title><g:message code="content.create" default="Create Content"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'content.create', default: 'Create Content')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="content.list" default="Content List"/></g:link></span>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <g:hasErrors bean="${contentInstance}">
    <div class="errors">
      <g:renderErrors bean="${contentInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="title"><g:message code="content.title" default="Title"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'title', 'errors')}">
            <g:textField name="title" maxlength="200" value="${fieldValue(bean: contentInstance, field: 'title')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="body"><g:message code="content.body" default="Body"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'body', 'errors')}">
            <g:textArea name="body" value="${fieldValue(bean: contentInstance, field: 'body')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="locale"><g:message code="content.locale" default="Locale"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'locale', 'errors')}">
            <g:localeSelect name="locale" value="${contentInstance?.locale}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="key"><g:message code="content.key" default="Key"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'key', 'errors')}">
            <g:textField name="key" maxlength="200" value="${fieldValue(bean: contentInstance, field: 'key')}"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="author"><g:message code="content.author" default="Author"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'author', 'errors')}">
            <g:select name="author.id" from="${com.synergyj.grain.auth.User.list()}" optionKey="id" value="${contentInstance?.author?.id}" noSelection="['null': '']"/>

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="type"><g:message code="content.type" default="Type"/>:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'type', 'errors')}">
            <g:select name="type" from="${com.synergyj.grain.content.ContentType?.values()}" value="${contentInstance?.type}"/>

          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
