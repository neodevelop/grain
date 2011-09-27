<div class="list">
  <table id="scheduludeCourseList" cellpadding="5" cellspacing="0" border="0" width="100%">
    <thead>
    <tr>

      <th width="30%"><g:message code="scheduledCourse.course" default="Course" /></th>

      <g:sortableColumn property="beginDate" title="Begin Date" titleKey="scheduledCourse.beginDate" />

      <g:sortableColumn property="limitRegistrationDate" title="Limit Registration Date" titleKey="scheduledCourse.limitRegistrationDate" />

      <g:sortableColumn property="costByCourse" title="Cost By Course" titleKey="scheduledCourse.costByCourse" />

      <g:sortableColumn property="scheduledCourseStatus" title="Status" titleKey="scheduledCourse.scheduledCourseStatus" />

      <th>&nbsp;</th>

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

        <td><g:formatDate date="${scheduledCourse.limitRegistrationDate}" format="dd-MMMM-yy" locale="es" /></td>

        <td>$ <g:formatNumber number="${scheduledCourse.costByCourse}" format="#,##0.00;(#,##0.00)" /></td>

        <td>${scheduledCourse.scheduledCourseStatus}</td>

        <td>
          <g:link controller="studentsGroup" action="show" id="${scheduledCourse?.id}">
            <g:message code="studentsGroup.show" default="See group"/>
          </g:link>
        </td>

        <td>
          <g:link controller="studentsGroup" action="attendance" id="${scheduledCourse?.id}">
            <g:message code="studentsGroup.attendance" default="Attendance"/>
          </g:link>
        </td>

      </tr>
    </g:each>
    </tbody>
  </table>
</div>