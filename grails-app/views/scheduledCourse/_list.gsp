<table id="scheduludeCourseList" class="table table-striped" width="100%">
  <thead>
    <tr>
      <th width="30%"><g:message code="scheduledCourse.course" default="Course" /></th>
      <g:sortableColumn property="beginDate" title="Begin Date" titleKey="scheduledCourse.beginDate" />
      <g:sortableColumn property="costByCourse" title="Cost By Course" titleKey="scheduledCourse.costByCourse" />
      <g:sortableColumn property="scheduledCourseStatus" title="Status" titleKey="scheduledCourse.scheduledCourseStatus" />
      <th>&nbsp;</th>
    </tr>
  </thead>
  <tbody>
  <g:each in="${scheduledCourseList}" status="i" var="scheduledCourse">
    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
      <td>
        <sec:ifAllGranted roles="ROLE_ADMIN">
          <g:link controller="scheduledCourse" action="show" id="${scheduledCourse.id}">
            ${fieldValue(bean: scheduledCourse, field: "course")}
            <g:set var="mapId" value="sc${scheduledCourse.id}"/>
            <g:if test="${hasPendingPayments[mapId]}">
              <img src="${resource(dir:'themes/wb/icon',file:'money.png')}" width="16" height="16" />
              <b/><g:message code="payment.awaiting"/></b>
            </g:if>
          </g:link>
        </sec:ifAllGranted>

        <sec:ifAllGranted roles="ROLE_USER">
          <sec:ifNotGranted roles="ROLE_ADMIN">
            <!-- TODO: Mostrar el detalle del curso(temario) -->
            ${fieldValue(bean: scheduledCourse, field: "course")}
          </sec:ifNotGranted>
        </sec:ifAllGranted>

      </td>
      <td><g:formatDate date="${scheduledCourse.beginDate}" format="dd-MMMM-yy" locale="es"/></td>
      <td><g:formatNumber number="${scheduledCourse.costByCourse}" locale="es_MX" format="\$ ###,##0.00" /></td>
      <td>${scheduledCourse.scheduledCourseStatus}</td>
      <td>
        <div class="btn-group">
          <g:link controller="studentsGroup" action="show" id="${scheduledCourse?.id}" class="btn">
            <g:message code="studentsGroup.show" default="See group"/>
          </g:link>
          <g:link controller="studentsGroup" action="attendance" id="${scheduledCourse?.id}" class="btn">
            <g:message code="studentsGroup.attendance" default="Attendance"/>
          </g:link>
          <g:link controller="evaluation" action="feedback" id="${scheduledCourse?.id}" class="btn">
            <g:message code="studentsGroup.feedback" default="Feedback"/>
          </g:link>
        </div>
      </td>
    </tr>
  </g:each>
  </tbody>
</table>
