
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

  <div class="modal hide" id="uploadReceiptForPaymentModal">
    <div class="modal-header">
      <button type="button" class="close" data-dismiss="modal">×</button>
      <h3>Subir comprobante de pago</h3>
    </div>
    <div class="modal-body">
      <g:render template="/common/alertForResponse"/>
      <g:render template="fileUpload"/>
    </div>

    <div class="modal-footer">
      <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
    </div>
  </div>

  <script src='http://synergyj.com/resources/jquery.form.js' type='text/javascript'></script>
</body>