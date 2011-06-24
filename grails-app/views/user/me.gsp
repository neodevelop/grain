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
  <h4><g:message code="me.email"/>:</h4><h3>${user.email}</h3>
  <br>
  <h4><g:message code="me.name"/>:</h4><h3>${user.firstName ?: 'vacío'}</h3>
  <br>
  <h4><g:message code="me.lastname"/>:</h4><h3>${user.lastName ?: 'vacío'}</h3>
  <br>
  <h4><g:message code="me.company"/>:</h4><h3>${user.company ?: 'vacío'}</h3>
  <br>
  <h4><g:message code="me.website"/>:</h4><h3>${user.website ?: 'vacío'}</h3>
  <br>
  <br/>
  <g:link mapping="updateme" class="action">
    <g:message code="me.update"/>
  </g:link>
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
      </ul>
      <div id="tabs-1">
        <g:render template="/registration/list" model="[registrationList:myRegistrations]" />
      </div>
    </div>
  </g:else>
  </sec:ifNotGranted>
</div>
</body>
