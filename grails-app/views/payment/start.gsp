<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.info', default: 'Payment info')}"/>
  <script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js/payment',file:'start.js')}"></script>
  <link rel="stylesheet" type="text/css" href="http://craigsworks.com/projects/qtip2/packages/latest/jquery.qtip.css" />
  <script type="text/javascript" src="http://craigsworks.com/projects/qtip2/packages/latest/jquery.qtip.js"></script>
  <script type="text/javascript" src="http://flesler-plugins.googlecode.com/files/jquery.scrollTo-1.4.2-min.js"></script>
</head>
<body>
<g:form action="pay" name="makePayment">
<div id="left">

  <div id="leftbox">

    <div id="title">
      <g:message code="course.name"/>:
      <div id="courseName">${payment.registration.scheduledCourse.course}</div>
    </div>

    <table id="breakDownDetail">
      <tr class="finalPrice">
        <td><g:message code="payment.amount"/>:</td>
        <td class="finalAmount">
          $ <span id="finalAmount"><g:formatNumber number="${payment.amount}" format="#,###.00" locale="MX"/></span>
        </td>
      </tr>
    </table>

    <br/><br/><br/><br/><br/><br/>

  </div>

</div>
<div id="right">
  <div id="rightbox">

    <h2>Escoge entre estos dos medios de pago</h2>

    <div class="paymentOption groupOption2">
      <g:radio id="transferencia" value="transferencia" name="paymentOption"/>
      Transferencia electrónica
    </div>
    <div class="paymentOption groupOption2">
      <g:radio id="dineromail" value="dineromail" name="paymentOption"/>
      Otro medios de pago<br/>
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
  <g:render template="spei" model="[pay:'pay']"/>
</div>

<div class="clearer"></div>
<div id="paymentDineroMail" class="payment">
  <g:render template="dineroMail"  model="[pay:'pay']"/>
</div>
<g:hiddenField name="totalToPay" value="${payment.amount}"/>
<g:hiddenField name="transactionId" value="${payment.transactionId}"/>

</g:form>
</body>
