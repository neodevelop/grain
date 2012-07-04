<%@ page import="com.synergyj.grain.course.ReceiptStatus; com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='mainContent'/>
  <r:require module="home"/>
  <r:require module="me"/>
</head>
<body>
  <!-- TODO: Si la sesion es de instructor y es el día de la clase entonces mostramos lista de asistencia -->
  <sec:ifAllGranted roles="ROLE_ADMIN">
    <h1>Grupos de inscritos</h1>
    <g:render template="/scheduledCourse/adminList" model="[scheduledCourseList:scheduledCourseList]"/>
  </sec:ifAllGranted>

  <sec:ifNotGranted roles="ROLE_ADMIN">
  <g:if test="${!myRegistrations && !registrationsCodeForScheduledCourses}">
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
        <g:render template="/registration/codes" model="[registrationsCodeForScheduledCourses:registrationsCodeForScheduledCourses]"/>
        <g:render template="/registration/list" model="[registrationList:myRegistrations]" />
      </div>
    </div>
  </g:else>
  </sec:ifNotGranted>
  <!-- Plugin de formulario -->
  <script src='http://synergyj.com/resources/jquery.form.js' type='text/javascript'></script>
</body>
