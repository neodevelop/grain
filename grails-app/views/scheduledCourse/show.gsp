<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta name="layout" content="mainContent" />
  <title><g:message code="scheduledCourse.show" default="Show ScheduledCourse" /></title>
  <script type="text/javascript" src="https://raw.github.com/fgelinas/timepicker/master/jquery.ui.timepicker.js"></script>
  <link rel="stylesheet" href="https://raw.github.com/fgelinas/timepicker/master/jquery-ui-timepicker.css"/>
  <r:require module="common"/>
  <r:require module="scheduledCourses"/>
</head>
<body>

<g:link class="btn" action="list">
  <g:message code="scheduledCourse.list" default="ScheduledCourse List" />
</g:link>
<g:link class="btn" action="create">
  <g:message code="scheduledCourse.new" default="New ScheduledCourse" />
</g:link>
<button id="showAddCourseSession" class="btn">
  <g:message code="scheduledCourse.addSessions" default="Add Session" />
</button>
<button id="showAddExpense" class="btn">
  <g:message code="expense.add" default="Add Expense" />
</button>
<button id="showAddInstructor" class="btn">
  <g:message code="instructor.add" default="Add Instructor" />
</button>


<div class="row">
  <div class="span3">
    <h2>Datos del curso</h2>
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
  </div>
  <div class="span3">
    <h2>Sesiones de curso</h2>
    <div id="sessionList">
      <ul>
        <g:each in="${scheduledCourseInstance?.courseSessions?.sort()}" var="courseSessionInstance">
          <li id="sessionCourse${courseSessionInstance.id}">
            <span id="sessionCourseValue${courseSessionInstance.id}">${courseSessionInstance?.encodeAsHTML()}</span>
            &nbsp;-&nbsp;
            <span id="sessionCourseEndTime${courseSessionInstance.id}">
              <g:formatDate date="${courseSessionInstance?.sessionEndTime}" format="HH:mm"/>
            </span>
            <a class="updateSession" href="${createLink(controller:'courseSession',action:'updateAsync',id:courseSessionInstance.id)}">
              Update
            </a>
            <a class="deleteSession" href="${createLink(controller:'courseSession',action:'deleteAsync',id:courseSessionInstance.id)}">
              Delete
            </a>
          </li>
        </g:each>
      </ul>
    </div>
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
  <div class="span7">
    <h2><g:message code="scheduledCourse.expenses" default="Course Expenses" />:</h2>
    <table id="expenseList" class="table table-condensed">
      <thead>
        <tr>
          <th>Description</th>
          <th>Category</th>
          <th>Time</th>
          <th>&nbsp;</th>
          <th>Amount</th>
        </tr>
      </thead>
      <tbody>
        <tr class="expense" style="display:none;">
          <td><span class="description"></span></td>
          <td><span class="expenseCategory"></span></td>
          <td><span class="expenseTime"></span></td>
          <td>
            &nbsp;
          </td>
          <td><span class="amount"></span></td>
        </tr>
        <g:set var="totalExpenses" value="${new BigDecimal(0)}" />
        <g:each in="${scheduledCourseInstance?.expenses?.sort()}" var="expenseInstance">
        <tr id="expense${expenseInstance.id}">
          <td>${expenseInstance.description}</td>
          <td>${expenseInstance.expenseCategory}</td>
          <td><g:formatDate date="${expenseInstance.expenseTime}" format="dd/MM/yyyy HH:mm"/></td>
          <td>
            <!--
            <a class="updateExpense" href="${createLink(controller:'expense',action:'updateAsync',id:expenseInstance.id)}">
              Update
            </a>
            -->
          </td>
          <td align="right">
            $ <g:formatNumber number="${expenseInstance.amount}" locale="MX" format="#,###.00"/>
          </td>
        </tr>
        <g:set var="totalExpenses" value="${totalExpenses + expenseInstance.amount}" />
        </g:each>
        <tfoot>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td align="right">
              <b>Total</b>
            </td>
            <td align="right">
              <b>$ <g:formatNumber number="${totalExpenses}" locale="MX" format="#,###.00"/></b>
            </td>
          </tr>
        </tfoot>
      </tbody>
    </table>
  </div>
</div>

<g:form>
  <g:hiddenField name="id" value="${scheduledCourseInstance?.id}" />
  <div class="form-actions">
    <g:actionSubmit class="btn btn-primary" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" />
    <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
  </div>
</g:form>






<div id="newSessionCourse" title="Add a new session" style="display:none;">
  <g:formRemote
      name="addSessionToScheduledCourse"
      url="[controller:'scheduledCourse',action:'newSessionToCourse']"
      onSuccess="reacting(data)"
      onComplete="restoreLink()" style="height:100%;" >
    <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
    <g:hiddenField name="courseSessionId" value="0"/>
    Fecha de la Sesión: <g:textField name="sessionStartTime" />
    Hora de inicio: <g:textField name="sessionHourStartTime" />
    Duración(hrs.): <g:select from="${2..9}" name="duration" value="9" />
    <input type="submit" value="Add Session to Course" id="addSession" name="addSession"/>
  </g:formRemote>
</div>

<!-- TODO: Agregar promociones -->



<div id="newExpense" title="Add a new expense" style="display:none;">
  <g:formRemote
      name="addExpenseToScheduledCourse"
      url="[controller:'expense',action:'addToScheduledCourse']"
      onSuccess="addExpenseToTable(data)"
      onComplete="restoreForm()" style="height:100%;" >
    <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
    <g:hiddenField name="expenseId" value="0"/>
    <g:render template="/expense/form" model="[expenseInstance:expenseInstance]"/>
    <input type="submit" value="Add Expense to Course" id="addExpense" name="addExpense"/>
  </g:formRemote>
</div>




<div id="newInstructor" title="Add instructor to this course" style="display:none;">
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
<br/><br/>
<div id="addStudentsToCourse">
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

</body>
</html>
