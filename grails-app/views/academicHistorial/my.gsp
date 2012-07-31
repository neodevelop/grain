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

  <h2>Tus registros</h2>

  <table class="table table-striped">
    <thead>
      <tr>
        <th>#</th>
        <th>Curso</th>
        <th>Fecha de inicio</th>
        <th>Duración</th>
        <th>Status</th>
        <th>&nbsp;</th>
      </tr>
    </thead>
    <tbody>
      <g:each in="${registrationsForThisUser}" var="registration" status="i">
      <tr>
        <td>${i+1}</td>
        <td>${registration.scheduledCourse.course.name}</td>
        <td>
          <g:formatDate date="${registration.scheduledCourse.beginDate}" format="dd-MMMM-yy" locale="es" />
        </td>
        <td>${registration.scheduledCourse.durationInHours} hrs.</td>
        <td>
          ${g.message(code:registration.registrationStatus.code)}
        </td>
        <td>
          
        </td>
      </tr>
      </g:each>
    </tbody>
  </table>

  <!--table class="table table-condensed">
    <thead>
      <tr>
        <th>#</th>
        <th>Course</th>
        <th>Fecha de registro</th>
      </tr>
    </thead>
    <tbody>
      <g:each in="${registrationsNoConfirmed}" var="registrationCode" status="i">
      <tr>
        <td>${i+1}</td>
        <td>${registrationCode.getScheduledCourseForCurrent()}</td>
        <td>
          <g:formatDate date="${registrationCode.dateCreated}" format="dd-MMMM-yy" locale="es" />
        </td>
      </tr>
      </g:each>
    </tbody>
  </table-->

</body>
</html>