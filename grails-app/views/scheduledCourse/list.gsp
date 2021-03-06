<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  
  <meta name="layout" content="mainContent" />
  <title><g:message code="scheduledCourse.list" default="Scheduled Course List" /></title>
  
  <r:require module="paginator"/>
</head>
<body>
  <g:link class="btn btn-primary" action="create">
    <g:message code="scheduledCourse.new" default="New ScheduledCourse" />
  </g:link>
  <div class="page-header">
    <h1><g:message code="scheduledCourse.list" default="Scheduled Course List" />
      <small>Lista de cursos calendarizdos</small>
    </h1>
  </div>

  <g:render template="list" model="[scheduledCourseList:scheduledCourseInstanceList,hasPendingPayments:hasPendingPayments]"/>

  <div class="pagination">
    <g:paginate total="${scheduledCourseInstanceTotal}" />
  </div>

</body>
</html>
