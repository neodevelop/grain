<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='main'/>
  <r:require module="common"/>
  <r:script>
  $(function(){
    $("a.submit").click(function(){
      $("#paymentOption").val($(this).attr("name"));
      $("form#makePayment").submit();
      return false;
    });
  });
  </r:script>
</head>
<body>

<div class="page-header">
  <h1>Efectúa tu pago
    <small>${message(code:'payment.start',default:"Starting your payment you make sure you have a place reserved in this course.")}</small>
  </h1>
</div>
<g:form action="pay" name="makePayment">
<div class="row">
  <div class="span6">
    <div class="well">
      <h3>${payment.registration.scheduledCourse.course.name}</h3>
      <dl class="dl-horizontal">
        <dt><g:message code="payment.amount"/>:</dt>
        <dd>
          <span id="finalAmount"><g:formatNumber number="${payment.amount}" locale="es_MX" format="\$ ###,##0.00"/></span>
        </dd>
      </dl>
    </div>
  </div>
  <div class="span6">
    &nbsp;
  </div>
</div>

<div class="row">
  <div class="span4">
    <h2>Pago en efectivo</h2>
    <g:render template="efectivo" model="[pay:'pay']"/>
  </div>
  <div class="span4">
    <h2>Transferencia electrónica</h2>
    <g:render template="spei" model="[pay:'pay']"/>
  </div>
  <div class="span4">
    <h2>Tarjetas de crédito</h2>
    <g:render template="tc" model="[pay:'pay']"/>
  </div>
</div>

<g:hiddenField name="totalToPay" value="${payment.amount}"/>
<g:hiddenField name="transactionId" value="${payment.transactionId}"/>
<g:hiddenField name="paymentOption" value=""/>
</g:form>
</body>
