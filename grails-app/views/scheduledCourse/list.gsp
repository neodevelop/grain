
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <title><g:message code="scheduledCourse.list" default="ScheduledCourse List" /></title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="scheduledCourse.new" default="New ScheduledCourse" /></g:link></span>
</div>
<div class="body">
  <h1><g:message code="scheduledCourse.list" default="ScheduledCourse List" /></h1>
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
  </g:if>
  <div class="list">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="scheduledCourse.id" />

        <th><g:message code="scheduledCourse.course" default="Course" /></th>

        <g:sortableColumn property="beginDate" title="Begin Date" titleKey="scheduledCourse.beginDate" />

        <g:sortableColumn property="limitRegistrationDate" title="Limit Registration Date" titleKey="scheduledCourse.limitRegistrationDate" />

        <g:sortableColumn property="costByCourse" title="Cost By Course" titleKey="scheduledCourse.costByCourse" />

      </tr>
      </thead>
      <tbody>
      <g:each in="${scheduledCourseInstanceList}" status="i" var="scheduledCourseInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${scheduledCourseInstance.id}">${fieldValue(bean: scheduledCourseInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: scheduledCourseInstance, field: "course")}</td>

          <td><g:formatDate date="${scheduledCourseInstance.beginDate}" format="dd-MMMM-yy" /></td>

          <td><g:formatDate date="${scheduledCourseInstance.limitRegistrationDate}" format="dd-MMMM-yy" /></td>

          <td>$ <g:formatNumber number="${scheduledCourseInstance.costByCourse}" format="#,##0.00;(#,##0.00)" /></td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${scheduledCourseInstanceTotal}" />
  </div>
</div>
</body>
</html>
