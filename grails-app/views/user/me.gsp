<%@ page import="com.synergyj.grain.course.ReceiptStatus; com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='mainContent'/>
  <!-- Plugin de formulario -->
  <script src='http://synergyj.com/resources/jquery.form.js' type='text/javascript'></script>
  <r:require module="home"/>
  <r:require module="me"/>
</head>
<body>
<div id="right">

  <sec:ifAllGranted roles="ROLE_ADMIN">

  <div id="tabs" style="width:650px;">
    <g:render template="/scheduledCourse/adminList" model="[scheduledCourseList:scheduledCourseList]"/>
  </div>

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
</div>

  <div id="lightbox" style="display:none;"></div>
  <div id="imageReceipt" style="display:none;">

  </div>
  <div id="userDataForm" style="display:none;">
    <div class="title"> Gracias por tu pago! </div>
    <div class="sub-title">
      Por favor, selecciona el archivo(jpeg) que comprueba tu pago
    </div>
    <g:form name="fileuploadForm" controller="payment" action="fileupload" method="POST" enctype="multipart/form-data">
      <g:hiddenField name="paymentNumber" value=""/>
      <label>Archivo:</label><br/>
      <input id="file" type="file" name="file" class="file" size="30" />
      <div align="center">
      <input value="Subir archivo..." class="continue" tabindex="3" type="submit">
    </g:form>
    <div id="fileupload" style="display: none;">
      <img src="${resource(dir:'themes/wb/images',file:'ajax-loader.gif')}" title="progress" alt="loader"/>
    </div>
    <div id="okMessage" style="display:none;"></div>
    <div id="errorMessage" style="display:none;"></div>
  </div>
</body>
