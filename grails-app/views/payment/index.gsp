<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.info', default: 'Payment info')}"/>
  <script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js/payment',file:'index.js')}"></script>
  <link rel="stylesheet" type="text/css" href="http://craigsworks.com/projects/qtip2/packages/latest/jquery.qtip.css" />
  <script type="text/javascript" src="http://craigsworks.com/projects/qtip2/packages/latest/jquery.qtip.js"></script>
  <script type="text/javascript" src="http://flesler-plugins.googlecode.com/files/jquery.scrollTo-1.4.2-min.js"></script>
</head>
<body>
<g:form action="">
<div id="left">

  <div id="leftbox">
    <g:render template="/registration/simpleShow" model="[registration:registration]"/>

    <div class="percentOption groupOption1">
      <g:radio id="half" value="" name="percentOption"/>
      Aparta tu lugar con el 50%<br/>( $ <span id="halfCostByCourse"></span> )
    </div>
    <div class="percentOption groupOption1">
      <g:radio id="full" value="" name="percentOption"/>
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
      Otros medios de pago<br/>
      <img src="${createLinkTo(dir:'themes/wb/icon',file:'visa-icon.gif')}" title="visa" alt="visa"/>
      <img src="${createLinkTo(dir:'themes/wb/icon',file:'mastercard-icon.gif')}" title="mastercard" alt="mastercard"/>
      <img src="${createLinkTo(dir:'themes/wb/icon',file:'amex-icon.png')}" title="amex" alt="amex"/>
      <img src="${createLinkTo(dir:'themes/wb/icon',file:'7-eleven-icon.png')}" title="7eleven" alt="7eleven"/>
      <img src="${createLinkTo(dir:'themes/wb/icon',file:'oxxo-icon.gif')}" title="oxxo" alt="oxxo"/>
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
</g:form>
</body>
