<%@ page import="com.synergyj.grain.content.Content" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <parameter name="pageHeader" value="${g.message(code: 'content.list', default: 'Content List')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="content.new" default="New Content"/></g:link></span>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="content.id"/>

        <g:sortableColumn property="title" title="Title" titleKey="content.title"/>

        <g:sortableColumn property="body" title="Body" titleKey="content.body"/>

        <g:sortableColumn property="locale" title="Locale" titleKey="content.locale"/>

        <g:sortableColumn property="key" title="Key" titleKey="content.key"/>

        <th><g:message code="content.author" default="Author"/></th>

      </tr>
      </thead>
      <tbody>
      <g:each in="${contentInstanceList}" status="i" var="contentInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${contentInstance.id}">${fieldValue(bean: contentInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: contentInstance, field: "title")}</td>

          <td>${fieldValue(bean: contentInstance, field: "body")}</td>

          <td>${fieldValue(bean: contentInstance, field: "locale")}</td>

          <td>${fieldValue(bean: contentInstance, field: "key")}</td>

          <td>${fieldValue(bean: contentInstance, field: "author")}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${contentInstanceTotal}"/>
  </div>
</div>
</body>
</html>
