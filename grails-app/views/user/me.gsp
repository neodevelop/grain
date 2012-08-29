<%@ page import="com.synergyj.grain.course.ReceiptStatus; com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content="mainContent"/>
  
  <r:require module="me"/>
</head>
<body>
  <!-- TODO: Si la sesion es de instructor y es el día de la clase entonces mostramos lista de asistencia -->
  <sec:ifAllGranted roles="ROLE_ADMIN">
    <h1>Grupos de inscritos</h1>
    <g:render template="/scheduledCourse/adminList" model="[scheduledCourseList:scheduledCourseList]"/>
  </sec:ifAllGranted>

  <sec:ifNotGranted roles="ROLE_ADMIN">
    <div class="page-header">
      <h1>Próximos cursos <small>Aparta tu lugar</small></h1>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>#</th>
          <th>Curso</th>
          <th>Fecha de inicio</th>
          <th>Precio</th>
          <th>Duración</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${scheduledCourses}" var="sc" status="i">
        <tr>
          <td>${i+1}</td>
          <td>${sc.course.name}</td>
          <td><g:formatDate date="${sc.beginDate}" format="EEEE dd-MMMM-yy" locale="es"/></td>
          <td>${sc.durationInHours} hrs.</td>
          <td><g:formatNumber number="${sc.costByCourse}" locale="es_MX" format="\$ ###,##0.00"/></td>
          <td><a href="${sc.course.urlLandingPage}" class="btn">Más información</a></td>
        </tr>
        </g:each>
      </tbody>
    </table>
    
  </sec:ifNotGranted>
  <!-- Plugin de formulario -->
  <script src='http://synergyj.com/resources/jquery.form.js' type='text/javascript'></script>
</body>
