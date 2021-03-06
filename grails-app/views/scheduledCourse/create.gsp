
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  
  <meta name="layout" content="mainContent" />
  <title><g:message code="scheduledCourse.create" default="Create ScheduledCourse" /></title>
  
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
  </fieldset>
  </g:form>
</body>
</html>
