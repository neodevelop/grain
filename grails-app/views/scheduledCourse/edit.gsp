
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <title><g:message code="scheduledCourse.edit" default="Edit ScheduledCourse" /></title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="scheduledCourse.list" default="ScheduledCourse List" /></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="scheduledCourse.new" default="New ScheduledCourse" /></g:link></span>
</div>
<div class="body">
  <h1><g:message code="scheduledCourse.edit" default="Edit ScheduledCourse" /></h1>
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
  </g:if>
  <g:hasErrors bean="${scheduledCourseInstance}">
    <div class="errors">
      <g:renderErrors bean="${scheduledCourseInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form method="post" >
    <g:hiddenField name="id" value="${scheduledCourseInstance?.id}" />
    <g:hiddenField name="version" value="${scheduledCourseInstance?.version}" />
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="course"><g:message code="scheduledCourse.course" default="Course" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'course', 'errors')}">
            <g:select name="course.id" from="${com.synergyj.grain.course.Course.list()}" optionKey="id" value="${scheduledCourseInstance?.course?.id}"  />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="costByCourse"><g:message code="scheduledCourse.costByCourse" default="Cost By Course" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'costByCourse', 'errors')}">
            <g:textField name="costByCourse" value="${fieldValue(bean: scheduledCourseInstance, field: 'costByCourse')}" />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="costByModule"><g:message code="scheduledCourse.costByModule" default="Cost By Module" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'costByModule', 'errors')}">
            <g:textField name="costByModule" value="${fieldValue(bean: scheduledCourseInstance, field: 'costByModule')}" />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="courseSessions"><g:message code="scheduledCourse.courseSessions" default="Course Sessions" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'courseSessions', 'errors')}">

            <ul>
              <g:each in="${scheduledCourseInstance?.courseSessions}" var="courseSessionInstance">
                <li><g:link controller="courseSession" action="show" id="${courseSessionInstance.id}">${courseSessionInstance?.encodeAsHTML()}</g:link></li>
              </g:each>
            </ul>
            <g:link controller="courseSession" params="['scheduledCourse.id': scheduledCourseInstance?.id]" action="create"><g:message code="courseSession.new" default="New CourseSession" /></g:link>


          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="beginDate"><g:message code="scheduledCourse.beginDate" default="Begin Date" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'beginDate', 'errors')}">
            <g:datePicker name="beginDate" value="${scheduledCourseInstance?.beginDate}" precision="day"  />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="limitRegistrationDate"><g:message code="scheduledCourse.limitRegistrationDate" default="Limit Registration Date" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'limitRegistrationDate', 'errors')}">
            <g:datePicker name="limitRegistrationDate" value="${scheduledCourseInstance?.limitRegistrationDate}" precision="day"  />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="status"><g:message code="scheduledCourse.status" default="Status:" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'scheduledCourseStatus', 'errors')}">
            <g:select name="scheduledCourseStatus" from="${com.synergyj.grain.course.ScheduledCourseStatus?.values()}" value="${scheduledCourseInstance?.scheduledCourseStatus}"  />
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
    </div>
  </g:form>
</div>
</body>
</html>
