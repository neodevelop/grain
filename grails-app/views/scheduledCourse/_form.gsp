<div class="control-group">
  <label class="control-label" for="course"><g:message code="scheduledCourse.course" default="Course" />:</label>
  <g:select name="course.id" from="${com.synergyj.grain.course.Course.list()}" optionKey="id" value="${scheduledCourseInstance?.course?.id}"  />
</div>    

<div class="control-group">
  <label class="control-label" for="costByCourse"><g:message code="scheduledCourse.costByCourse" default="Cost By Course" />:</label>
  <div class="input-prepend">
    <span class="add-on">$</span><g:textField name="costByCourse" value="${scheduledCourseInstance?.costByCourse}" class="input-mini"/>
  </div>
</div>

<div class="control-group">
  <label class="control-label" for="costByModule"><g:message code="scheduledCourse.costByModule" default="Cost By Module" />:</label>
  <div class="input-prepend">
    <span class="add-on">$</span><input type="text" name="costByModule" id="costByModule" value="${scheduledCourseInstance?.costByModule}" class="input-mini"/>
  </div>
</div>

<div class="control-group">
  <label class="control-label" for="beginDate"><g:message code="scheduledCourse.beginDate" default="Begin Date" />:</label>
  <g:datePicker name="beginDate" value="${scheduledCourseInstance?.beginDate}" precision="day"  />
</div>

<div class="control-group">
  <label class="control-label" for="limitRegistrationDate"><g:message code="scheduledCourse.limitRegistrationDate" default="Limit Registration Date" />:</label>
  <g:datePicker name="limitRegistrationDate" value="${scheduledCourseInstance?.limitRegistrationDate}" precision="day"  />
</div>

<div class="control-group">
  <label class="control-label" for="durationInHours"><g:message code="scheduledCourse.durationInHours" default="Duration in Hours" />:</label>
  <g:textField name="durationInHours" value="${fieldValue(bean: scheduledCourseInstance, field: 'durationInHours')}" class="input-mini"/>
</div>

<div class="control-group">
  <label class="control-label" for="status"><g:message code="scheduledCourse.status" default="Status" />:</label>
  <g:select name="scheduledCourseStatus" from="${com.synergyj.grain.course.ScheduledCourseStatus?.values()}" value="${scheduledCourseInstance?.scheduledCourseStatus}"  />
</div>

<div class="control-group">
  <label class="control-label" for="fullAddress"><g:message code="scheduledCourse.fullAddress" default="Full Address" />:</label>
  <g:textArea name="fullAddress" value="${scheduledCourseInstance.fullAddress ?: ''}" rows="" cols="" />
</div>

<div class="control-group">
  <label class="control-label" for="geolocation"><g:message code="scheduledCourse.geolocation" default="Geolocation" />:</label>
  <g:textField name="geolocation" value="${scheduledCourseInstance?.geolocation}"/>
  <g:render template="/common/map" model="[refField:'geolocation',width:480,height:240]" />
</div>
<r:script>
  $("select[id^=beginDate],select[id^=limitRegistrationDate]").addClass("span1");
</r:script>