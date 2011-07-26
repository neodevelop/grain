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
        <label for="status"><g:message code="scheduledCourse.status" default="Status" />:</label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'scheduledCourseStatus', 'errors')}">
        <g:select name="scheduledCourseStatus" from="${com.synergyj.grain.course.ScheduledCourseStatus?.values()}" value="${scheduledCourseInstance?.scheduledCourseStatus}"  />
      </td>
    </tr>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="fullAddress"><g:message code="scheduledCourse.fullAddress" default="Full Address" />:</label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'fullAddress', 'errors')}">
        <g:textArea name="fullAddress" value="${scheduledCourseInstance.fullAddress ?: ''}" rows="" cols="" />
      </td>
    </tr>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="geolocation"><g:message code="scheduledCourse.geolocation" default="Geolocation" />:</label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: scheduledCourseInstance, field: 'geolocation', 'errors')}">
        <g:hiddenField name="geolocation" value="${scheduledCourseInstance?.geolocation}"/>
        <g:render template="/common/map" model="[refField:'geolocation',width:480,height:240]" />
      </td>
    </tr>

    </tbody>
  </table>
</div>