<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta name="layout" content="mainContent" />
  <title><g:message code="scheduledCourse.show" default="Show ScheduledCourse" /></title>
  <link rel="stylesheet" href="https://raw.github.com/fgelinas/timepicker/master/jquery-ui-timepicker.css"/>
  <r:require module="common"/>
  <r:require module="scheduledCourses"/>
  <r:require module="jquery-ui"/>
</head>
<body>
<div class="btn-group">
  <g:link class="btn" action="list">
    <g:message code="scheduledCourse.list" default="ScheduledCourse List" />
  </g:link>
  <g:link class="btn" action="create">
    <g:message code="scheduledCourse.new" default="New ScheduledCourse" />
  </g:link>
  <button id="showAddCourseSession" class="btn" data-toggle="modal" href="#newSessionCourse" >
    <g:message code="scheduledCourse.addSessions" default="Add Session" />
  </button>
  <button id="showAddExpense" data-toggle="modal" href="#newExpense" class="btn">
    <g:message code="expense.add" default="Add Expense" />
  </button>
  <button id="showAddInstructor" data-toggle="modal" href="#newInstructor" class="btn">
    <g:message code="instructor.add" default="Add Instructor" />
  </button>
  <button id="showAddPromotions" data-toggle="modal" href="#newPromotion" class="btn">
    Add promotions
  </button>
</div>

<div class="row">
  <div class="span3">
    <h2>Datos del curso</h2>
    <g:render template="/scheduledCourse/simpleShow" model="[scheduledCourseInstance:scheduledCourseInstance]" />
  </div>
  <div class="span3">
    <h2>Sesiones de curso</h2>
    <g:render template="/courseSession/list" model="[courseSessions:scheduledCourseInstance?.courseSessions]" />
  </div>
  <div class="span3">
    <h2><g:message code="scheduledCourse.fullAddress" default="Full Address" />:</h2>
    <g:hiddenField name="geolocation" value="${scheduledCourseInstance?.geolocation}"/>
    <g:render template="/common/map" model="[refField:'geolocation',width:290,height:150]" />
    ${scheduledCourseInstance.fullAddress ?: 'Dirección'}
  </div>
</div>

<div class="row">
  <div class="span3">
    <h2><g:message code="scheduledCourse.instructors" default="Instructors"/>:</h2>
    <ul id="instructors">
      <g:each in="${scheduledCourseInstance.instructors}" var="instructor">
        <li id="instructor${instructor.id}">
          <g:remoteLink controller="scheduledCourse" action="removeInstructor" id="${scheduledCourseInstance.id}"
                        params="[instructorId:instructor.id]" onComplete="removeFromInstructors(${instructor.id})">
            ${instructor}
          </g:remoteLink>
        </li>
      </g:each>
    </ul>
  </div>
  <div class="span6">
    <h2><g:message code="scheduledCourse.promotions" default="Current promotions" />:</h2>
    <g:render template="/promotionPerScheduledCourse/list" model="[promotions:scheduledCourseInstance.promotions]" />
  </div>
</div>

<div class="row">
  <div class="span9">
    <h2><g:message code="scheduledCourse.expenses" default="Course Expenses" />:</h2>
    <g:render template="/expense/list" model="[expenses:scheduledCourseInstance?.expenses]" />
  </div>
</div>

<g:form>
  <g:hiddenField name="id" value="${scheduledCourseInstance?.id}" />
  <div class="form-actions">
    <g:actionSubmit class="btn btn-primary" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" />
    <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
  </div>
</g:form>

<g:render template="/scheduledCourse/sessionForm" model="[scheduledCourseInstance:scheduledCourseInstance]" />

<g:render template="/scheduledCourse/expenseForm" model="[scheduledCourseInstance:scheduledCourseInstance,expenseInstance:expenseInstance]" />

<g:render template="/scheduledCourse/instructorForm" model="[scheduledCourseInstance:scheduledCourseInstance,instructors:instructors]" />

<g:render template="/scheduledCourse/promotionForm" model="[scheduledCourseInstance:scheduledCourseInstance]" />

<script type="text/javascript" src="https://raw.github.com/fgelinas/timepicker/master/jquery.ui.timepicker.js"></script>
</body>
</html>
