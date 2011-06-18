<!-- TODO: Esta vista debe ser reutilizable para los pagos del 50% restante -->
<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.detail', default: 'Payment detail')}"/>
  <g:javascript>
    $(function(){
      $(":radio").hide();
      $("div.percentOption").click(function(){
        $("div#leftbox :radio").attr("checked",false);
        $(":first",this).attr("checked",true);
        highlight("div#leftbox div","percentOption");
        bothSelected();
      });
      $("div.paymentOption").click(function(){
        $("div#rightbox :radio").attr("checked",false);
        $(":first",this).attr("checked",true);
        highlight("div#rightbox div","paymentOption");
        bothSelected();
      });
    });

    function highlight(selector,optionSelector){
      $(selector).addClass(optionSelector);
      $(":checked").parent().removeClass(optionSelector );
      $(":checked").parent().addClass("optionSelected");
    }

    function bothSelected(){
      if($("input[name='percentOption']").is(":checked") && $("input[name='paymentOption']").is(":checked")){
        $("div#confirm").show();
      }
    }

    function showPayment(){
      $("div#payment").show();
      $("div#confirm").hide();
      afterSend();
      $("div#rightbox > div").unbind("click");
      $("div#leftbox > div").unbind("click");
    }

    function beforeSend(){
      $("div#loader").show();
    }
    function afterSend(){
      $("div#loader").hide();
    }
  </g:javascript>
</head>
<body>
<g:form>
<div id="left">
  <div id="leftbox">
    <div class="percentOption">
      <g:radio id="half" value="2" name="percentOption"/>
      Aparta tu lugar con el 50%<br/>( $ <g:formatNumber number="${finalAmount/2}" format="#,###.00"/> )
    </div>
    <div class="percentOption">
      <g:radio id="full" value="1" name="percentOption"/>
      Paga el total de tu curso<br/>( $ <g:formatNumber number="${finalAmount}" format="#,###.00"/> )
    </div>
  </div>
  <div id="confirm" style="display: none;">
    <g:submitToRemote url="[action:'create']" value="Confirmar" class="confirm" update="payment" before="beforeSend()" onComplete="showPayment();"/>
  </div>
</div>
<div id="right">
  <div id="rightbox">
    <div class="paymentOption">
      <g:radio id="transferencia" value="transferencia" name="paymentOption"/>
      Transferencia electrónica
    </div>
    <div class="paymentOption">
      <g:radio id="dineromail" value="dineromail" name="paymentOption"/>
      Otros medios de pago
    </div>
  </div>
  <div id="loader" style="text-align: center;margin-top: 20px; display: none;">
    <img src="${createLinkTo(dir:'themes/wb/images',file:'ajax-loader.gif')}" alt="loader">
  </div>
  <div id="payment" style="display: none;">

  </div>
</div>
</g:form>
</body>
