<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="mainContent" />
  <title><g:message code="studentsGroup.show" default="Students Group" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'studentsGroup.show', default: 'Students Group')}"/>
  <r:require module="jquery-ui"/>
  <r:require module="studentsGroup"/>
</head>
<body>
  <h3>${scheduledCourse.course}</h3>
  <h4>Inicia: ${formatDate(date: scheduledCourse.beginDate, format: "dd - MMMM - yyyy")}</h4>
  
  <ul class="nav nav-tabs">
    <li class="active"><a href="#tabs-0" data-toggle="tab">Usuarios interesados</a></li>
    <li><a href="#tabs-1" data-toggle="tab">Usuarios registrados</a></li>
    <li><a href="#tabs-2" data-toggle="tab">Usuarios inscritos</a></li>
    <li><a href="#tabs-3" data-toggle="tab">Usuarios no inscritos</a></li>
    <li><a href="#tabs-4" data-toggle="tab">Pagos de inscritos</a></li>
    <li><a href="#tabs-5" data-toggle="tab">Lista de gastos</a></li>
    <li><a href="#tabs-6" data-toggle="tab">Ingresos</a></li>
  </ul>
  
  <div class="tab-content" class="tab-content">
    <div class="tab-pane active" id="tabs-0">
      <div align="center">
        <i>Aquí se presenta los correos de las personas que han entrado a la Landing Page y han dejado sus datos.<br/>
          El total es de <b>${emailsFromLP.size()}</b> participantes</i><br/>
      </div>
      <table width="100%" class="registrationsList table table-condensed">
        <thead>
        <tr>
          <th>Correo electrónico</th>
          <th>Fecha de registro</th>
          <th>Token</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${emailsFromLP}" var="r">
          <tr>
            <td>${r.username}</td>
            <td><g:formatDate date="${r.dateCreated}" format="dd / MMMM / yyyy hh:mm a"/></td>
            <td>${r.token}</td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="tab-pane fade" id="tabs-1">
      <div align="center">
        <i>Aquí se presenta a todos los participantes que han dado clic al botón de confirmación de registro.<br/>
        El total es de <b>${registrations.size()}</b> participantes</i><br/>
      </div>
      <table width="100%" class="registrationsList table table-condensed">
        <thead>
          <tr>
            <th>Correo electrónico</th>
            <th>Nombre</th>
            <th>Fecha de registro</th>
          </tr>
        </thead>
        <tbody>
        <g:each in="${registrations}" var="registration">
          <tr>
            <td>${registration.student.email}</td>
            <g:set var="fullName" value="${registration.student.firstName + registration.student.lastName}"/>
            <td>${fullName ?: 'El usuario no ha cambiado su nombre'}</td>
            <td><g:formatDate date="${registration.dateCreated}" format="dd / MMMM / yyyy hh:mm a"/></td>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
    <div class="tab-pane fade" id="tabs-2">
      <div align="center">
        <i>Aquí están los participantes que han confirmado de forma verbal o por correo su asistencia al curso, o bien,
        ya han pagado parte o el total del curso y por lo tanto ya están confirmados para asistir.<br/>
        El total es de <b>${registrationsInGroup.size()}</b> participantes</i>
      </div>
      <g:render template="detail" model="[tableName:'studentsInGroup',registrationGroup:registrationsInGroup,action:'removeStudent']" />
    </div>
    <div class="tab-pane fade" id="tabs-3">
      <div align="center">
        <i>Aquí están los participantes que NO han iniciado el proceso de pago y tampoco han confirmado su asistencia.<br/>
        El total es de <b>${registrationsNoGroup.size()}</b> participantes</i>
      </div>
      <g:render template="detail" model="[tableName:'studentsNoGroup',registrationGroup:registrationsNoGroup,action:'addStudent']" />
    </div>

    <div class="tab-pane fade" id="tabs-4">
      <div align="center">
        <i>Aquí está el detalle de los pagos de las personas que están inscritas al curso.</i><br/>
      </div>
      <g:render template="paymentsDetail" model="[registrationGroup:registrationsInGroup]"/>
    </div>

    <div class="tab-pane fade" id="tabs-5">
      <div align="center">
        <i>Aquí está el detalle de los gastos generados en este curso.</i><br/>
      </div>
      <g:render template="/expense/list" model="[expensesList:expenses]"/>
    </div>

    <div class="tab-pane fade" id="tabs-6">
      <div align="center">
        <i>Se presenta el detalle de ingresos menos gastos que se generaron en el curso.<br/>
          Asistieron <b>${registrationsInGroup.size()}</b> participantes</i><br/>
      </div>
      <g:render template="summary" model="[registrationGroup:registrationsInGroup,expensesList:expenses]"/>
    </div>
  </div>
</body>
</html>
