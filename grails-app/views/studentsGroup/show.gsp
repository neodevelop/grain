<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="mainContent" />
  <title><g:message code="studentsGroup.show" default="Students Group" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'studentsGroup.show', default: 'Students Group')}"/>
  <script language="JavaScript" src="${resource(dir:'themes/wb/js/studentsGroup',file:'show.js')}"></script>
  <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'tables.js')}"></script>
</head>
<body>
<div class="content">
  <h3>${scheduledCourse.course}</h3>
  <h4>Inicia: ${formatDate(date: scheduledCourse.beginDate, format: "dd - MMMM - yyyy")}</h4>
  <br/>
  <div id="tabs" style="width:100%;">
    <ul>
      <li><a href="#tabs-0">Usuarios interesados</a></li>
      <li><a href="#tabs-1">Usuarios registrados</a></li>
      <li><a href="#tabs-2">Usuarios inscritos</a></li>
      <li><a href="#tabs-3">Usuarios no inscritos</a></li>
      <li><a href="#tabs-4">Pagos de inscritos</a></li>
      <li><a href="#tabs-5">Lista de gastos</a></li>
      <li><a href="#tabs-6">Ingresos</a></li>
    </ul>

    <div id="tabs-0">
      <div align="center">
        <i>Aquí se presenta los correos de las personas que han entrado a la Landing Page y han dejado sus datos.<br/>
          El total es de <b>${emailsFromLP.size()}</b> participantes</i><br/>
      </div>
      <table width="100%" class="registrationsList" cellpadding="5" cellspacing="0">
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
    <div id="tabs-1">
      <div align="center">
        <i>Aquí se presenta a todos los participantes que han dado clic al botón de confirmación de registro.<br/>
        El total es de <b>${registrations.size()}</b> participantes</i><br/>
      </div>
      <table width="100%" class="registrationsList" cellpadding="5" cellspacing="0">
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
    <div id="tabs-2">
      <div align="center">
        <i>Aquí están los participantes que han confirmado de forma verbal o por correo su asistencia al curso, o bien,
        ya han pagado parte o el total del curso y por lo tanto ya están confirmados para asistir.<br/>
        El total es de <b>${registrationsInGroup.size()}</b> participantes</i>
      </div>
      <g:render template="detail" model="[tableName:'studentsInGroup',registrationGroup:registrationsInGroup,action:'removeStudent']" />
    </div>
    <div id="tabs-3">
      <div align="center">
        <i>Aquí están los participantes que NO han iniciado el proceso de pago y tampoco han confirmado su asistencia.<br/>
        El total es de <b>${registrationsNoGroup.size()}</b> participantes</i>
      </div>
      <g:render template="detail" model="[tableName:'studentsNoGroup',registrationGroup:registrationsNoGroup,action:'addStudent']" />
    </div>

    <div id="tabs-4">
      <div align="center">
        <i>Aquí está el detalle de los pagos de las personas que están inscritas al curso.<br/>
      </div>
      <g:render template="paymentsDetail" model="[registrationGroup:registrationsInGroup]"/>
    </div>

    <div id="tabs-5">
      <div align="center">
        <i>Aquí está el detalle de los gastos generados en este curso.<br/>
      </div>
      <g:render template="/expense/list" model="[expensesList:expenses]"/>
    </div>

    <div id="tabs-6">
      <div align="center">
        <i>Se presenta el detalle de ingresos menos gastos que se generaron en el curso.<br/>
          Asistieron <b>${registrationsInGroup.size()}</b> participantes</i><br/>
      </div>
      <g:render template="summary" model="[registrationGroup:registrationsInGroup,expensesList:expenses]"/>
    </div>

  </div>
</div>
</body>
</html>
