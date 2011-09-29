<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="wb" />
  <title><g:message code="studentsGroup.show" default="Students Group" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'studentsGroup.show', default: 'Students Group')}"/>
  <script language="JavaScript" src="${resource(dir:'themes/wb/js/studentsGroup',file:'show.js')}"></script>
</head>
<body>
<div class="content">
  <h3>${scheduledCourse.course} / ${formatDate(date: scheduledCourse.beginDate, format: "dd - MMMM - yyyy")}</h3>

  <h4>Usuarios en el grupo</h4>
  <g:render template="detail" model="[tableName:'studentsInGroup',registrationGroup:registrationsInGroup,action:'removeStudent']" />

  <h4>Usuarios registrados al curso</h4>
  <g:render template="detail" model="[tableName:'studentsNoGroup',registrationGroup:registrationsNoGroup,action:'addStudent']" />

</div>
</body>
</html>
