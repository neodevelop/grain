<%@ page import="com.synergyj.grain.course.ScheduledCourseStatus" %>
<g:each in="${registrationsCodeForScheduledCourses}" var="registrationCode">
  <g:set var="scheduledCourse" value="${registrationCode.scheduledCourseForCurrent}"/>
  <g:if
      test="${scheduledCourse.scheduledCourseStatus == ScheduledCourseStatus.SCHEDULED || scheduledCourse.scheduledCourseStatus == ScheduledCourseStatus.PLANNING}">
    <table class="registration" cellpadding="0" cellspacing="0">
      <tr class="title">
        <td class="titleLeft">
          ${scheduledCourse.course}
        </td>
        <td class="titleRight">
          ${scheduledCourse.course.courseKey}
        </td>
      </tr>
      <tr class="content">
        <td class="contentLeft">
          <img src="${resource(dir: 'themes/wb/images', file: 'icon_calendar.png')}" alt="calendar" width="24px"
               height="24px"/>
          <g:message code="registration.beginDate"/><br/>
          <b><g:formatDate date="${scheduledCourse.beginDate}" format="EEEE dd/MMMM/yyyy"/></b>
        </td>
        <td class="contentRight">
          <img src="${resource(dir: 'themes/wb/icon', file: 'attention.png')}" alt="valid"/>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <g:link controller="registration" action="confirm" params="[scheduledCourseId:scheduledCourse.id,code:registrationCode.token]" class="action">
            <g:message code="registration.want"/>
          </g:link>
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
  </g:if>
</g:each>