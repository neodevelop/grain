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
    <g:render template="/courseSession/list" model="[courseSession:scheduledCourseInstance?.courseSessions]" />
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
    <table id="expenseList" class="table table-condensed">
      <thead>
        <tr>
          <th>#</th>
          <th>Promocion</th>
          <th>Vigencia</th>
          <th>Tipo</th>
          <th>Descuento</th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${scheduledCourseInstance.promotions}" var="promotionForThisScheduledCourse" status="i">
        <tr>
          <td>${i+1}</td>
          <td>${promotionForThisScheduledCourse.promotion}</td>
          <td><g:formatDate date="${promotionForThisScheduledCourse.validUntil}" format="dd-MMMM-yy" /></td>
          <td>${promotionForThisScheduledCourse.promotion.discount} %</td>
          <td>${promotionForThisScheduledCourse.promotion.kindPromotion}</td>
        </tr>
        </g:each>
      </tbody>
    </table>
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

<div id="newSessionCourse" class="modal hide">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Datos de sesión de curso</h3>
  </div>
  <div class="modal-body">
  <g:formRemote
      name="addSessionToScheduledCourse"
      url="[controller:'scheduledCourse',action:'newSessionToCourse']"
      onSuccess="reacting(data)"
      onComplete="restoreLink()" class="form-horizontal">
    <fieldset>
      <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
      <g:hiddenField name="courseSessionId" value="0"/>
      <div class="control-group">
        <label class="control-label">Fecha de la Sesión:</label>
        <div class="controls"><g:textField name="sessionStartTime" /></div>
      </div>
      <div class="control-group">
        <label class="control-label">Hora de inicio:</label>
        <div class="controls"><g:textField name="sessionHourStartTime" /></div>
      </div>
      <div class="control-group">
        <label class="control-label">Duración(hrs.):</label>
        <div class="controls"><g:select from="${2..9}" name="duration" value="9"  class="span1"/></div>
      </div>
    </fieldset>
  </g:formRemote>
  </div>
  <div class="modal-footer">
    <a href="#" id="addSession" class="btn btn-primary">Send session info</a>
    <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  </div>
</div>

<!-- TODO: Agregar promociones -->

<div id="newExpense" title="Add a new expense" class="modal hide">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Add expense to this course</h3>
  </div>
  <div class="modal-body">
  <g:formRemote
      name="addExpenseToScheduledCourse"
      url="[controller:'expense',action:'addToScheduledCourse']"
      onSuccess="addExpenseToTable(data)"
      onComplete="restoreForm()" class="form-horizontal" >
    <fieldset>
    <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
    <g:hiddenField name="expenseId" value="0"/>
    <g:render template="/expense/form" model="[expenseInstance:expenseInstance]"/>
    </fieldset>
  </g:formRemote>
  </div>
  <div class="modal-footer">
    <a href="#" id="addExpense" class="btn btn-primary">Add Expense to Course</a>
    <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  </div>
</div>

<div id="newInstructor" class="modal hide">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Add instructor to this course</h3>
  </div>
  <div class="modal-body">
  <ul id="selectInstructors">
    <g:each in="${instructors}" var="instructor">
      <li id="instructor${instructor.id}">
        <g:remoteLink controller="scheduledCourse" action="addInstructor" id="${scheduledCourseInstance.id}"
                      params="[instructorId:instructor.id]" onSuccess="addToInstructors(${instructor.id})"
                      onComplete="restoreInstructorButton()">
          ${instructor}
      </g:remoteLink>
      </li>
    </g:each>
  </ul>
  </div>
  <div class="modal-footer">
    <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  </div>
</div>

<div id="newPromotion" class="modal hide">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Add promotion to this course</h3>
  </div>
  <div class="modal-body">
    hola mundo
  </div>
  <div class="modal-footer">
    <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  </div>
</div>

<div id="addStudentsToCourse" class="modal hide">
  <g:formRemote name="addStudents" url="[controller: 'scheduledCourse',action: 'addStudents']"
                update="statusAfterAddStudents" before="beforeAddStudentsToCourse();"
                after="afterAddStudentsToCourse();">
    Datos separados por coma:<br/>
    <i>correo,nombre,apellidos</i><br/>
    Ejemplo: <b>mail@mail.com,Juan,Reyes Zuñiga</b><br/>
    <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
    <g:textArea name="studentsData" rows="10" cols="30"/><br/>
    <input type="submit" name="send" value="Add this students"/>
  </g:formRemote>
  <div id="statusAfterAddStudents"></div>
</div>
<script type="text/javascript" src="https://raw.github.com/fgelinas/timepicker/master/jquery.ui.timepicker.js"></script>
</body>
</html>
