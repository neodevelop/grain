<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.detail', default: 'Payment detail')}"/>
  <g:javascript>
    $(function(){
      $("div.percentOption").click(function(){
        $("div#leftbox :radio").attr("checked",false);
        $(":first",this).attr("checked",true);
      });
      $("div.paymentOption").click(function(){
        $("div#rightbox :radio").attr("checked",false);
        $(":first",this).attr("checked",true);
      });
    });
  </g:javascript>
</head>
<body>
<g:form>
<div id="left">
  <div id="leftbox">
    <div class="percentOption">
      Aparta tu lugar con el 50%...
      <g:radio value="50" name="percentOption"/>
    </div>
    <div class="percentOption">
      Paga el total de tu curso...
      <g:radio value="100" name="percentOption"/>
    </div>
  </div>
</div>
<div id="right">
  <div id="rightbox">
    <div class="paymentOption">
      Transferencia electrónica
      <g:radio value="transferencia" name="paymentOption"/>
    </div>
    <div class="paymentOption">
      Otros medios de pago
      <g:radio value="transferencia" name="paymentOption"/>
    </div>
  </div>
</div>
</g:form>
</body>
