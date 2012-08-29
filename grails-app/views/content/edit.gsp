<%@ page import="com.synergyj.grain.content.Content" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="content.edit" default="Edit Content"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'content.edit', default: 'Edit Content')}"/>
  <r:require module="common"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="content.list" default="Content List"/></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="content.new" default="New Content"/></g:link></span>
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
  <g:form method="post">
    <g:hiddenField name="id" value="${contentInstance?.id}"/>
    <g:hiddenField name="version" value="${contentInstance?.version}"/>
    <g:render template="form" model="contentInstance:contentInstance" />
    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}"/></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/></span>
    </div>
  </g:form>
</div>
</body>
</html>
