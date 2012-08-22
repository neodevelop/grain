
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="mainContent" />
  <title><g:message code="scheduledCourse.create" default="Create ScheduledCourse" /></title>
  <r:require module="common"/>
</head>
<body>

  <div class="page-header">
    <h1>${g.message(code: 'scheduledCourse.create', default: 'Create ScheduledCourse')}
      <small>New scheduled course</small>
    </h1>
  </div>

  <g:form action="save" method="post" class="form-horizontal">
    <fieldset>
      <g:render template="form" model="[scheduledCourseInstance:scheduledCourseInstance]"/>
      <div class="form-actions">
        <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'create', 'default': 'Create')}" />
      </div>
  </g:form>
  </fieldset>
</body>
</html>
