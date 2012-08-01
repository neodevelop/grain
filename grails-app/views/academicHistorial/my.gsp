<%@ page import="com.synergyj.grain.course.RegistrationStatus" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="mainContent" />
  <title><g:message code="academicHistorial.my" default="My Academic Historial" /></title>
  <r:require module="common"/>
</head>
<body>
  <div class="page-header">
    <h1>Mi historial académico
      <small>El registro de tus cursos</small>
    </h1>
  </div>
  <h2>Tu entrenamiento</h2>
  <g:render template="/registration/list" model="[registrationList:registrationsForThisUser]"/>
  <h3>Tus registros</h3>
  <g:render template="/registration/codes" model="[registrationsCodes:registrationsCodes,registeredScheduledCourses:registrationsForThisUser*.scheduledCourse]"/>
</body>
</html>