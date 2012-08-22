
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="mainContent" />
  <title><g:message code="scheduledCourse.edit" default="Edit ScheduledCourse" /></title>
  <r:require module="common"/>
</head>
<body>
  <g:link class="btn" action="list"><g:message code="scheduledCourse.list" default="ScheduledCourse List" /></g:link>
  <g:link class="btn" action="create"><g:message code="scheduledCourse.new" default="New ScheduledCourse" /></g:link>

  <div class="page-header">
    <h1>${g.message(code: 'scheduledCourse.edit', default: 'Edit ScheduledCourse')}
      <small>Modifify scheduled course</small>
    </h1>
  </div>

  <g:hasErrors bean="${scheduledCourseInstance}">
    <div class="alert alert-error">
      <g:renderErrors bean="${scheduledCourseInstance}" as="list" />
    </div>
  </g:hasErrors>

  <g:form method="post" class="form-horizontal">
    <g:hiddenField name="id" value="${scheduledCourseInstance?.id}" />
    <g:hiddenField name="version" value="${scheduledCourseInstance?.version}" />
    <g:render template="form" model="[scheduledCourseInstance:scheduledCourseInstance]"/>
    <div class="form-actions">
      <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'update', 'default': 'Update')}" />
      <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
    </div>
  </g:form>

</body>
</html>
