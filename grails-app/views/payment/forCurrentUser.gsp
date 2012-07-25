
<head>
  <title><g:message code='course.payments' default="Your payments"/></title>
  <meta name='layout' content='mainContent'/>
  <r:require module="common"/>
  <r:require module="paymentForCurrentUser"/>
</head>
<body>
  <div class="page-header">
  <h1>Historial de pagos
    <small>Detalle de pagos realizados y pendientes</small>
  </h1>
  </div>
  <g:each in="${registrations}" var="registration">
    <h2>${registration.scheduledCourse.course.name} <small>${g.message(code:registration.registrationStatus.code)}</small></h2>
    <g:render template="/payment/tableDetail" model="[registration:registration]" />
  </g:each>

  <div id="uploadReceiptForPayment">
    <g:render template="fileUpload"/>
  </div>
</body>