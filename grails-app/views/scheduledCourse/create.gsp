
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="main" />
  <title><g:message code="scheduledCourse.create" default="Create ScheduledCourse" /></title>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="scheduledCourse.list" default="ScheduledCourse List" /></g:link></span>
</div>
<div class="body">
  <h1><g:message code="scheduledCourse.create" default="Create ScheduledCourse" /></h1>
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
  </g:if>
  <g:hasErrors bean="${scheduledCourseInstance}">
    <div class="errors">
      <g:renderErrors bean="${scheduledCourseInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form action="save" method="post" >
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
            <label for="open"><g:message code="scheduledCourse.open" default="Is open?" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'open', 'errors')}">
            <g:checkBox name="open" value="${scheduledCourseInstance?.open}" />
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
    </div>
  </g:form>
</div>
</body>
</html>
