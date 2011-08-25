<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="wb" />
  <title><g:message code="studentsGroup.attendance" default="Attendance" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'studentsGroup.attendance', default: 'Attendance')}"/>
  <script language="JavaScript" src="${createLinkTo(dir:'themes/wb/js/studentsGroup',file:'attendance.js')}"></script>
  <script type="text/javascript" language="javascript" src="${createLinkTo(dir:'js',file:'tables.js')}"></script>
</head>
<body>
<div class="content">
  <h3>${studentsGroup.keyStudentsGroup}</h3>

  <div class="list">
    <table cellpadding="5" cellspacing="0" border="0" width="100%">
      <thead>
        <tr>
          <th>
            <g:message code="login.username"/>
          </th>
          <g:each in="${studentsGroup?.scheduledCourse?.courseSessions?.sort()}" var="courseSession">
          <th>
            ${courseSession}
          </th>
          </g:each>
        </tr>
      </thead>
      <tbody>
        <g:each in="${registrations}" var="registration">
        <tr>
          <td>${registration.student.email}<br/>${registration.student.firstName} ${registration.student.lastName} </td>
          <g:each in="${registration?.courseSessions.sort()}" var="courseSession">
          <td valign="middle">
            <g:remoteLink controller="studentsGroup" action="checkAttendance" id="${courseSession.id}" onSuccess="changeAttendanceStatus(data,${courseSession.id});">
            <g:if test="${courseSession.attended}">
              <span id="sessionPerRegistration${courseSession.id}">
              <img src="${createLinkTo(dir:'themes/wb/icon',file:'green.png')}" width="24" height="24" title="attended${courseSession.id}" alt="attended${courseSession.id}"/>
              </span>
            </g:if>
            <g:else>
              <span id="sessionPerRegistration${courseSession.id}">
              <img src="${createLinkTo(dir:'themes/wb/icon',file:'red.png')}" width="24" height="24" title="attended${courseSession.id}" alt="attended${courseSession.id}"/>
              </span>
            </g:else>
            ${courseSession.courseSession}
            </g:remoteLink>
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
