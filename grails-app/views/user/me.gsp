<%@ page import="com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.title', default: 'This is me')}"/>
  <script language="JavaScript" src="${createLinkTo(dir:'themes/wb/js/registration',file:'list.js')}"></script>
  <g:javascript>
    $(function(){
      $("div#tabs").tabs();
      $("#accordion").accordion({ header:'div.note' });
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

  <sec:ifAllGranted roles="ROLE_ADMIN">

  <div id="tabs" style="width:550px;">
    <ul>
      <g:each in="${scheduledCourseList}" var="scheduledCourse" status="i">
        <li><a href="#sc-${i}">${scheduledCourse.course.courseKey}</a></li>
      </g:each>
    </ul>

    <g:each in="${scheduledCourseList}" var="scheduledCourse" status="i">
    <div id="sc-${i}">
      <h1>Lista de inscritos</h1>
      <h3>Comienza: <g:formatDate date="${scheduledCourse.beginDate}" format="EEEE dd-MM-yy"/> </h3>
      <ul id="registrations">
      <g:each in="${registrationsPerScheduledCourse[scheduledCourse.course.courseKey]}" var="registration">
        <li><b>${registration?.student?.firstName ?: ''} ${registration?.student?.lastName ?: ''}</b> ${registration?.student?.email} - ${registration.registrationStatus}</li>
      </g:each>
      </ul>
    </div>
    </g:each>

  </div>

  </sec:ifAllGranted>

  <sec:ifNotGranted roles="ROLE_ADMIN">
  <g:if test="${!myRegistrations}">
    <h1>Aún no te has registrado a ningún curso</h1>
    <h3>Explora nuestro calendario e inscríbete!!!</h3>
    <p>
      <g:link controller="calendar" class="button">Ver el calendario</g:link>
    </p>
  </g:if>
  <g:else>
    <div id="tabs" style="width:550px;">
      <ul>
        <li><a href="#tabs-1">Estado de tus inscripciones</a></li>
        <li><a href="#tabs-2">Datos del curso</a></li>
        <li><a href="#tabs-3">Tus sesiones</a></li>
      </ul>
      <div id="tabs-1">
        <g:render template="/registration/list" model="[registrationList:myRegistrations]" />
      </div>
      <div id="tabs-2">
        <h3>${myRegisteredCourse?.scheduledCourse?.course?.name}</h3>
        <h4>${myRegisteredCourse?.scheduledCourse?.course?.courseKey}</h4>
        <p>${myRegisteredCourse?.scheduledCourse?.course?.overview}</p>
        <p>Costo del curso: <b>$ ${myRegisteredCourse?.scheduledCourse?.costByCourse} mxn</b></p>
      </div>
      <div id="tabs-3">
        <h3>${myRegisteredCourse?.scheduledCourse?.course?.name}</h3>
        <h4>${myRegisteredCourse?.scheduledCourse?.course?.courseKey}</h4>
        <ul>
          <g:each in="${myRegisteredCourse?.scheduledCourse?.courseSessions}" var="courseSession">
            <li><g:formatDate date="${courseSession?.sessionStartTime}" format="EEEE dd - MMMM - yyyy"/></li>
          </g:each>
        </ul>
        <p>
          <img src="${createLinkTo(file:'gc_button6_es.gif',dir:'themes/wb/images')}" alt="calendar"/>
        </p>
      </div>
    </div>
  </g:else>
  </sec:ifNotGranted>
</div>
</body>
