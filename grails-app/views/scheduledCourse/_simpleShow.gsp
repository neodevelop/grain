<dl class="dl-horizontal">
  <dt><g:message code="scheduledCourse.id" default="Id" />:</dt>
  <dd>${fieldValue(bean: scheduledCourseInstance, field: "id")}</dd>
  <dt><g:message code="scheduledCourse.course" default="Course" />:</dt>
  <dd><g:link controller="course" action="show" id="${scheduledCourseInstance?.course?.id}">${scheduledCourseInstance?.course?.encodeAsHTML()}</g:link></dd>
  <dt><g:message code="scheduledCourse.costByCourse" default="Cost By Course" />:</dt>
  <dd><g:formatNumber number="${scheduledCourseInstance?.costByCourse}" locale="es_MX" format="\$ ###,##0.00"/></dd>
  <dt><g:message code="scheduledCourse.costByModule" default="Cost By Module" />:</dt>
  <dd><g:formatNumber number="${scheduledCourseInstance?.costByModule}" locale="es_MX" format="\$ ###,##0.00"/></dd>
  <dt><g:message code="scheduledCourse.beginDate" default="Begin Date" />:</dt>
  <dd><g:formatDate date="${scheduledCourseInstance?.beginDate}" format="dd-MMMM-yy" /></dd>
  <dt><g:message code="scheduledCourse.status" default="Status" />:</dt>
  <dd>${scheduledCourseInstance.scheduledCourseStatus}</dd>
  <dt><g:message code="scheduledCourse.durationInHours" default="Duration In Hours" />:</dt>
  <dd>${scheduledCourseInstance?.durationInHours}</dd>
</dl>