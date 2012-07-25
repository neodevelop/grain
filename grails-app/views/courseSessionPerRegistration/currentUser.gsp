<head>
  <title><g:message code='registration.your.sessions' default="Your sessions"/></title>
  <meta name='layout' content='mainContent'/>
  <r:require module="common"/>
</head>
<body>
  <div class="page-header">
    <h1><g:message code='registration.your.sessions' default="Your sessions"/>
      <small>La asistencia a tu entrenamiento</small>
    </h1>
  </div>
  <g:each in="${registrations}" var="registration">
    <h2>${registration.scheduledCourse.course.name}</h2>
    <h3>${registration.scheduledCourse.durationInHours} hrs.</h3>
    <table class="table table-striped table-bordered table-condensed">
      <thead>
        <tr>
          <th>Sesión</th>
          <th>Fecha</th>
          <th>Horario</th>
          <th>Asistió</th>
        </tr>
      </thead>
      <tbody>
      <g:each in="${registration.courseSessions.sort()}" var="courseSessionPerRegistration" status="i">
        <tr>
          <td>${i+1}</td>
          <td>
            <g:formatDate date="${courseSessionPerRegistration.courseSession.sessionStartTime}" format="EEEE, dd/MMMM/yyyy"/>
          </td>
          <td>
            <g:formatDate date="${courseSessionPerRegistration.courseSession.sessionStartTime}" format="hh:mm aa"/> -
            <g:formatDate date="${courseSessionPerRegistration.courseSession.sessionEndTime}" format="hh:mm aa"/>
          </td>
          <td>
            <g:if test="${courseSessionPerRegistration.attended}">
              <span class="badge badge-success">
                <i class="icon-ok icon-white"></i>
              </span>
            </g:if>
            <g:else>
              <span class="badge badge-important">
                <i class="icon-remove icon-white"></i>
              </span>
            </g:else>
          </td>
        </tr>
      </g:each>
      </tbody>
    </table>
  </g:each>
</body>
