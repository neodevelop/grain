
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="wb" />
  <title><g:message code="scheduledCourse.edit" default="Edit ScheduledCourse" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'scheduledCourse.edit', default: 'Edit ScheduledCourse')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><g:link class="list" action="list"><g:message code="scheduledCourse.list" default="ScheduledCourse List" /></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="scheduledCourse.new" default="New ScheduledCourse" /></g:link></span>
</div>
<br/>
<div class="body">
  <g:hasErrors bean="${scheduledCourseInstance}">
    <div class="errors">
      <g:renderErrors bean="${scheduledCourseInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form method="post" >
    <g:hiddenField name="id" value="${scheduledCourseInstance?.id}" />
    <g:hiddenField name="version" value="${scheduledCourseInstance?.version}" />
    <g:render template="form" model="[scheduledCourseInstance:scheduledCourseInstance]"/>
    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
    </div>
  </g:form>
</div>
</body>
</html>
