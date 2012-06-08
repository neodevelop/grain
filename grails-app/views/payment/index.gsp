<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='main'/>
  <r:require module="home"/>
  <r:require module="payment"/>
</head>
<body>

<div class="page-header">
  <h1>Comienza tu pago
    <small>${message(code:'payment.start',default:"Starting your payment you make sure you have a place reserved in this course.")}</small>
  </h1>
</div>
<g:form action="create" name="makePayment">
<div class="row">
  <div class="span6">
    <div class="well">

      <g:render template="/registration/simpleShow" model="[registration:registration]"/>
      
      <div class="percentOption groupOption1">
        <g:radio id="half" value="" name="percentOption"/>
        Aparta tu lugar con el 50% ( $ <span id="halfCostByCourse"></span> )
      </div>
      <div class="percentOption groupOption1">
        <g:radio id="full" value="" name="percentOption"/>
        Paga el total de tu curso ( $ <span id="totalCostByCourse"></span>  )
      </div>

    </div>
  </div>
  <div class="span6">
    <g:render template="/promotion/showForPayment" model="[promotionsPerCourse:promotionsPerCourse]" />
    <div class="paymentOption groupOption2">
      <g:radio id="transferencia" value="transferencia" name="paymentOption"/>
      Transferencia electrónica
    </div>
    <div class="paymentOption groupOption2">
      <g:radio id="dineromail" value="dineromail" name="paymentOption"/>
      Otros medios de pago<br/>
      <img src="${resource(dir:'themes/wb/icon',file:'visa-icon.gif')}" title="visa" alt="visa"/>
      <img src="${resource(dir:'themes/wb/icon',file:'mastercard-icon.gif')}" title="mastercard" alt="mastercard"/>
      <img src="${resource(dir:'themes/wb/icon',file:'amex-icon.png')}" title="amex" alt="amex"/>
      <img src="${resource(dir:'themes/wb/icon',file:'7-eleven-icon.png')}" title="7eleven" alt="7eleven"/>
      <img src="${resource(dir:'themes/wb/icon',file:'oxxo-icon.gif')}" title="oxxo" alt="oxxo"/>
    </div>
  </div>
</div>

<div class="clearer"></div>
<div id="paymentSpei" class="payment">
  <g:render template="spei"/>
</div>

<div class="clearer"></div>
<div id="paymentDineroMail" class="payment">
  <g:render template="dineroMail"/>
</div>

<g:hiddenField name="registrationId" value="${registration.id}"/>
<g:hiddenField name="totalToPay" value=""/>
<g:hiddenField name="checkedPromotions" value=""/>
</g:form>

</body>