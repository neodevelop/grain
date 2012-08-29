<%@ page import="com.synergyj.grain.course.RegistrationStatus; com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="mainContent" />
  <title><g:message code="studentsGroup.attendance" default="Attendance" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'studentsGroup.attendance', default: 'Attendance')}"/>
  <script language="JavaScript" src="${resource(dir:'themes/wb/js/studentsGroup',file:'attendance.js')}"></script>
  <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'tables.js')}"></script>
</head>
<body>
<div class="content">
  <h3>${scheduledCourse.course} / ${formatDate(date: scheduledCourse.beginDate, format: "dd - MMMM - yyyy")}</h3>

  <div class="btn">
    <table cellpadding="5" cellspacing="0" border="0" width="100%">
      <thead>
        <tr>
          <th>
            <g:message code="login.username"/>
          </th>
          <g:each in="${scheduledCourse?.courseSessions?.sort()}" var="courseSession">
          <th>
            ${courseSession}
          </th>
          </g:each>
          <th>
            <g:message code="course.certified" default="Certificate"/>
          </th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${scheduledCourse.registrations}" var="registration">
        <g:if test="${registration.registrationStatus == RegistrationStatus.FINISHED || registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_PAYED_IN_GROUP || registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH_IN_GROUP}">
        <tr>
          <td>${registration.student.email}<br/>${registration.student.firstName} ${registration.student.lastName} </td>
          <g:each in="${registration?.courseSessions?.sort()}" var="courseSession">
          <td valign="middle">
            <g:remoteLink controller="studentsGroup" action="checkAttendance" id="${courseSession.id}" onSuccess="changeAttendanceStatus(data,${courseSession.id});">
            <g:if test="${courseSession.attended}">
              <span id="sessionPerRegistration${courseSession.id}">
              <img src="${resource(dir:'themes/wb/icon',file:'green.png')}" width="24" height="24" title="attended${courseSession.id}" alt="attended${courseSession.id}"/>
              </span>
            </g:if>
            <g:else>
              <span id="sessionPerRegistration${courseSession.id}">
              <img src="${resource(dir:'themes/wb/icon',file:'red.png')}" width="24" height="24" title="attended${courseSession.id}" alt="attended${courseSession.id}"/>
              </span>
            </g:else>
            ${courseSession.courseSession}
            </g:remoteLink>
          </td>
          </g:each>
          <td>
            <g:remoteLink controller="registration" action="toggleFinished" id="${registration.id}" onSuccess="changeRegistrationStatus(data,${registration.id});">
            <span id="registration${registration.id}">
            <g:if test="${!(registration.registrationStatus == RegistrationStatus.FINISHED)}">
              <img src="${resource(dir:'themes/wb/icon',file:'shuffle-off.png')}" width="24" height="24"/>
            </g:if>
            <g:else>
              <img src="${resource(dir:'themes/wb/icon',file:'shuffle-on.png')}" width="24" height="24"/>
            </g:else>
            </span>
            <g:message code="registration.generateCertificate" default="Generate"/>
            </g:remoteLink>
          </td>
        </tr>
        </g:if>
        </g:each>
      </tbody>
    </table>
  </div>
  <br/>
  <g:link controller="studentsGroup" action="createCertificate" id="${scheduledCourse.id}" class="action">
    Diplomas
  </g:link>

</div>
</body>
</html>
