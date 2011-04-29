<div class="list">
  <table id="scheduludeCourseList">
    <thead>
    <tr>

      <th><g:message code="scheduledCourse.course" default="Course" /></th>

      <g:sortableColumn property="beginDate" title="Begin Date" titleKey="scheduledCourse.beginDate" />

      <g:sortableColumn property="limitRegistrationDate" title="Limit Registration Date" titleKey="scheduledCourse.limitRegistrationDate" />

      <g:sortableColumn property="costByCourse" title="Cost By Course" titleKey="scheduledCourse.costByCourse" />

      <sec:ifAllGranted roles="ROLE_USER">
        <th>&nbsp;</th>
      </sec:ifAllGranted>

    </tr>
    </thead>
    <tbody>
    <g:each in="${scheduledCourseList}" status="i" var="scheduledCourse">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

        <td>${fieldValue(bean: scheduledCourse, field: "course")}</td>

        <td><g:formatDate date="${scheduledCourse.beginDate}" format="dd-MMMM-yy" /></td>

        <td><g:formatDate date="${scheduledCourse.limitRegistrationDate}" format="dd-MMMM-yy" /></td>

        <td>$ <g:formatNumber number="${scheduledCourse.costByCourse}" format="#,##0.00;(#,##0.00)" /></td>

        <sec:ifAllGranted roles="ROLE_ADMIN">
          <th>Inscribete</th>
        </sec:ifAllGranted>

      </tr>
    </g:each>
    </tbody>
  </table>
</div>