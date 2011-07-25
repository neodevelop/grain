
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="wb" />
  <title><g:message code="scheduledCourse.create" default="Create ScheduledCourse" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'scheduledCourse.create', default: 'Create ScheduledCourse')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><g:link class="list" action="list"><g:message code="scheduledCourse.list" default="ScheduledCourse List" /></g:link></span>
</div>
<br/>
<div class="body">
  <g:hasErrors bean="${scheduledCourseInstance}">
    <div class="errors">
      <g:renderErrors bean="${scheduledCourseInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form action="save" method="post" >
    <g:render template="form" model="[scheduledCourseInstance:scheduledCourseInstance]"/>
    <div class="buttons">
      <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
    </div>
  </g:form>
</div>
</body>
</html>
