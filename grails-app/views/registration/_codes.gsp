<%@ page import="com.synergyj.grain.course.ScheduledCourseStatus" %>
  <table class="table table-striped">
    <thead>
      <tr>
        <th>#</th>
        <th>Curso</th>
        <th><g:message code="registration.beginDate"/></th>
        <th>Duración</th>
        <th>&nbsp;</th>
      </tr>
    </thead>
    <tbody>
      <g:each in="${registrationsCodes}" var="registrationCode" status="i">
      <g:set var="scheduledCourse" value="${registrationCode.scheduledCourseForCurrent}"/>
      <g:set var="scheduledCourseStatus" value="${scheduledCourse.scheduledCourseStatus }" />
      <tr>
        <td>${i+1}</td>
        <td>${scheduledCourse.course.name}</td>
        <td><g:formatDate date="${scheduledCourse.beginDate}" format="EEEE dd / MMMM / yyyy"/></td>
        <td>${scheduledCourse.durationInHours} hrs.</td>
        <td>
          <g:if test="${registeredScheduledCourses.any{sc->sc == scheduledCourse}}">
            <span class="label label-success">Bien!</span> Ya has confirmado tu registro a este curso
          </g:if>
          <g:else>
            <g:if test="${scheduledCourseStatus == ScheduledCourseStatus.SCHEDULED || scheduledCourseStatus == ScheduledCourseStatus.PLANNING}">
              <g:link controller="registration" action="confirm" params="[scheduledCourseId:scheduledCourse.id,code:registrationCode.token]" class="btn btn-success">
                <g:message code="registration.want"/>
              </g:link>
            </g:if>
            <g:else>
              <span class="label label-info">Finalizado!</span> Este curso ha cerrado su registro
            </g:else>
          </g:else>
        </td>
      </tr>
      </g:each>
    </tbody>
  </table>