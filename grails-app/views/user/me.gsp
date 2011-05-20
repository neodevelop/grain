<%@ page import="com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.title', default: 'This is me')}"/>
  <g:javascript>
    $(function(){
      $("div#tabs").tabs();
    });
  </g:javascript>
</head>
<body>
<div id="left">
  <g:link mapping="updateme">Change my profile</g:link>
  <h4>e-m@il:</h4><h3>${user.email}</h3>
  <br>
  <h4>first name:</h4><h3>${user.firstName ?: 'empty'}</h3>
  <br>
  <h4>last name:</h4><h3>${user.lastName ?: 'empty'}</h3>
  <br>
  <h4>company:</h4><h3>${user.company ?: 'empty'}</h3>
  <br>
  <h4>website:</h4><h3>${user.website ?: 'empty'}</h3>
  <br>
  <h4>geolocation:</h4><h3>${user.geolocation ?: 'empty'}</h3>
  <br>
  <g:link mapping="updateme">Change my profile</g:link>
</div>
<div id="right">
  <g:if test="${!myRegisteredCourse}">
    <h1>Aún no te has registrado a ningún curso</h1>
    <h3>Explora nuestro calendario e inscríbete!!!</h3>
  </g:if>
  <g:else>
    <div id="tabs" style="width:550px;">
      <ul>
        <li><a href="#tabs-1">Estado de tu registro</a></li>
        <li><a href="#tabs-2">Datos del curso</a></li>
        <li><a href="#tabs-3">Tus sesiones</a></li>
      </ul>
      <div id="tabs-1">
        <h3>${myRegisteredCourse.scheduledCourse.course.name}</h3>
        <h4>${myRegisteredCourse.scheduledCourse.course.courseKey}</h4>
        Registro: <b><g:formatDate date="${myRegisteredCourse.registrationDate}" format="EEEE dd-MM-yyyy"/></b><br/>
        <g:if test="${myRegisteredCourse.registrationStatus == RegistrationStatus.REGISTERED}">
          <p align="center">
            <g:link class="button">Escoge tu forma de pago</g:link>
          </p>
          <p align="center">
            <img src="${createLinkTo(file:'mpagos_01.gif',dir:'themes/wb/images')}" alt="pagos"/>
          </p>
        </g:if>
        <g:if test="${myRegisteredCourse.registrationStatus == RegistrationStatus.PENDING_PAYMENT}">
          <a href="#" class="button">Esperamos tu pago</a>
        </g:if>
        <g:if test="${myRegisteredCourse.registrationStatus == RegistrationStatus.PAYED}">
          <a href="#" class="button">Gracias por tu pago, haz quedado registrado</a>
        </g:if>
        <g:if test="${myRegisteredCourse.registrationStatus == RegistrationStatus.IN_COURSE}">
          <a href="#" class="button">Estás en entrenamiento!!!</a>
        </g:if>
      </div>
      <div id="tabs-2">
        <h3>${myRegisteredCourse.scheduledCourse.course.name}</h3>
        <h4>${myRegisteredCourse.scheduledCourse.course.courseKey}</h4>
        <p>${myRegisteredCourse.scheduledCourse.course.overview}</p>
        <p>Costo del curso: <b>$ ${myRegisteredCourse.scheduledCourse.costByCourse} mxn</b></p>
      </div>
      <div id="tabs-3">
        <h3>${myRegisteredCourse.scheduledCourse.course.name}</h3>
        <h4>${myRegisteredCourse.scheduledCourse.course.courseKey}</h4>
        <ul>
          <g:each in="${myRegisteredCourse.scheduledCourse.courseSessions}" var="courseSession">
            <li><g:formatDate date="${courseSession?.sessionDate}" format="EEEE dd - MMMM - yyyy"/></li>
          </g:each>
        </ul>
        <p>
          <img src="${createLinkTo(file:'gc_button6_es.gif',dir:'themes/wb/images')}" alt="calendar"/>
        </p>
      </div>
    </div>
  </g:else>
</div>
</body>
