<%@ page import="com.synergyj.grain.course.ReceiptStatus; com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.title', default: 'This is me')}"/>
  <script language="JavaScript" src="${resource(dir:'themes/wb/js/registration',file:'list.js')}"></script>
  <script language="JavaScript" src="${resource(dir:'themes/wb/js/user',file:'me.js')}"></script>
  <!-- Plugin de formulario -->
  <script src='http://synergyj.com/resources/jquery.form.js' type='text/javascript'></script>
</head>
<body>
<div id="left">
  <h4><g:message code="me.email"/>:</h4><h3>${user.email}</h3>
  <br>
  <h4><g:message code="me.name"/>:</h4><h3>${user.firstName ?: 'vacío'}</h3>
  <br>
  <h4><g:message code="me.lastname"/>:</h4><h3>${user.lastName ?: 'vacío'}</h3>
  <br>
  <g:if test="${user?.company}">
  <h4><g:message code="me.company"/>:</h4><h3>${user.company ?: 'vacío'}</h3>
  <br>
  </g:if>
  <g:if test="${user?.website}">
  <h4><g:message code="me.website"/>:</h4><h3>${user.website ?: 'vacío'}</h3>
  <br>
  </g:if>
  <br/>
  <g:link mapping="updateme" class="action">
    <g:message code="me.update"/>
  </g:link>
  <br/><br/><br/>
  <g:link mapping="changePassword" class="action">
    <g:message code="me.changePassword"/>
  </g:link>
  <sec:ifAnyGranted roles="ROLE_ADMIN" >
    <br/><br/><br/>
    <g:link controller="course" class="action">
      <g:message code="course.label" default="Courses"/>
    </g:link>
    <br/><br/><br/>
    <g:link controller="scheduledCourse" class="action">
      <g:message code="scheduledcourse.label" default="Scheduled Courses"/>
    </g:link>
    <br/><br/><br/>
    <g:link controller="promotion" class="action">
      <g:message code="promotion.label" default="Promotions"/>
    </g:link>
    <br/><br/><br/>
    <g:link controller="promotionPerScheduledCourse" class="action">
      <g:message code="promotionPerScheduledCourse.label" default="Promotion Per Course"/>
    </g:link>
    <br/><br/><br/>
    <g:link controller="content" class="action">
      <g:message code="content.label" default="Contents"/>
    </g:link>
    <br/><br/><br/>
    <g:link controller="newsItem" class="action">
      <g:message code="newsItem.label" default="News Item"/>
    </g:link>
    <br/><br/><br/>
    <g:link controller="notification" class="action">
      <g:message code="notification.label" default="Notifications"/>
    </g:link>
  </sec:ifAnyGranted>


</div>
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
