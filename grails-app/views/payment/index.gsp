<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.info', default: 'Payment info')}"/>
  <script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js/payment',file:'index.js')}"></script>
</head>
<body>
<div id="left">

  <div id="leftbox">
    <g:render template="/registration/simpleShow" model="[registration:registration]"/>

    <div class="percentOption groupOption1">
      <g:radio id="half" value="2" name="percentOption"/>
      Aparta tu lugar con el 50%<br/>( $ <span id="halfCostByCourse"></span> )
    </div>
    <div class="percentOption groupOption1">
      <g:radio id="full" value="1" name="percentOption"/>
      Paga el total de tu curso<br/>( $ <span id="totalCostByCourse"></span>  )
    </div>

  </div>

</div>
<div id="right">
  <div id="rightbox">
    <g:render template="/promotion/showForPayment" model="[promotionsPerCourse:promotionsPerCourse]" />

    <div class="paymentOption groupOption2">
      <g:radio id="transferencia" value="transferencia" name="paymentOption"/>
      Transferencia electrónica
    </div>
    <div class="paymentOption groupOption2">
      <g:radio id="dineromail" value="dineromail" name="paymentOption"/>
      Otros medios de pago
    </div>

  </div>
</div>
</body>
