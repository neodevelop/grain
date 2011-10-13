<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="wb" />
  <title><g:message code="studentsGroup.show" default="Students Group" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'studentsGroup.show', default: 'Students Group')}"/>
  <script language="JavaScript" src="${resource(dir:'themes/wb/js/studentsGroup',file:'show.js')}"></script>
</head>
<body>
<div class="content">
  <h3>${scheduledCourse.course}</h3>
  <h4>Inicia: ${formatDate(date: scheduledCourse.beginDate, format: "dd - MMMM - yyyy")}</h4>
  <br/>
  <div id="tabs" style="width:100%;">
    <ul>
      <li><a href="#tabs-1">Usuarios registrados</a></li>
      <li><a href="#tabs-2">Usuarios inscritos</a></li>
      <li><a href="#tabs-3">Usuarios no inscritos</a></li>
      <li><a href="#tabs-4">Pagos de inscritos</a></li>
    </ul>
    <div id="tabs-1">
      <div align="center">
        <i>Aquí se presenta a todos los participantes que han dado clic al botón de confirmación de registro.<br/>
        El total es de <b>${registrations.size()}</b> participantes</i><br/>
      </div>
      <table width="100%">
        <thead>
          <tr>
            <td>Correo electrónico</td>
            <td>Nombre</td>
            <td>Fecha de registro</td>
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
          El total es de <b>${registrationsNoGroup.size()}</b> participantes</i>
      </div>
      <g:render template="paymentsDetail" model="[registrationGroup:registrationsInGroup]"/>
    </div>
  </div>
</div>
</body>
</html>
