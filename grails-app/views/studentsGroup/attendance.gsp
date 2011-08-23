<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="wb" />
  <title><g:message code="studentsGroup.attendance" default="Attendance" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'studentsGroup.attendance', default: 'Attendance')}"/>
</head>
<body>
<div class="content">
  <h3>${studentsGroup.keyStudentsGroup}</h3>

  <div class="list">
    <table width="100%">
      <thead>
        <tr>
          <td>
            <g:message code="login.username"/>
          </td>
          <g:each in="${studentsGroup?.scheduledCourse?.courseSessions}" var="courseSession">
          <td>
            ${courseSession}
          </td>
          </g:each>
        </tr>
      </thead>
      <tbody>
        <g:each in="${registrations}" var="registration">
        <tr>
          <td>${registration.student.email}</td>
          <g:each in="${registration?.courseSessions}" var="courseSession">
          <td>
            <g:checkBox name="mycheck"/>
          </td>
          </g:each>
        </tr>
        </g:each>
      </tbody>
    </table>
  </div>

</div>
</body>
</html>
