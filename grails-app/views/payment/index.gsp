<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.info', default: 'Payment info')}"/>
  <g:javascript>
    $(function(){
      startOver();
    });

    function startOver(){
      $("input[name^=email]").keyup(function(){
        var email = $(this).val();
        if(isValidEmailAddress(email)){
          $(this).siblings(":checkbox").attr('checked', true);
          $(this).parent().removeClass('uncheck').addClass('check');
          $(this).siblings("span").removeClass("optionUncheck").addClass("optionCheck");
          $(this).siblings(":checkbox").trigger("change");
        }else{
          $(this).siblings(":checkbox").attr('checked', false);
          $(this).parent().removeClass('check').addClass('uncheck');
          $(this).siblings("span").removeClass("optionCheck").addClass("optionUncheck");
          $(this).siblings(":checkbox").trigger("change");
        }
      });
      $("ul#promotions > li.select").click(function(){
        if($(this).children(":checkbox").attr("checked")){
          $(this).children(":checkbox").attr("checked",false);
        }else{
          $(this).children(":checkbox").attr("checked",true);
        }
        $(this).toggleClass('uncheck');
        $(this).toggleClass('check');
        $(this).children(":checkbox").trigger("change");
        toggleCheckbox($(this).children("span"));
      });

      $(":checkbox").change(function(){
        alert("cambio");

      });
    }

    function toggleCheckbox(selector){
      $(selector).toggleClass("optionUncheck");
      $(selector).toggleClass("optionCheck");
    }

    function isValidEmailAddress(emailAddress) {
      var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
      return pattern.test(emailAddress);
    }

    function disabledOptions(){
      $("div#rightbox input").attr("disabled",true);
      $("ul#promotions > li.select").removeClass("select");
      $("ul#promotions > li").unbind("click");
      $("div#applyPromotions").hide();
      $("p#reset").show();
    }

  </g:javascript>
</head>
<body>
<div id="left">

  <div id="leftbox">
    <g:render template="/registration/simpleShow" model="[registration:registration]"/>



    <div class="percentOption">
      <g:radio id="half" value="2" name="percentOption"/>
      Aparta tu lugar con el 50%<br/>( $  )
    </div>
    <div class="percentOption">
      <g:radio id="full" value="1" name="percentOption"/>
      Paga el total de tu curso<br/>( $  )
    </div>
  </div>

</div>
<div id="right">
  <div id="rightbox">
    <g:render template="/promotion/showForPayment" model="[promotionsPerCourse:promotionsPerCourse]" />
    <div class="paymentOption">
      <g:radio id="transferencia" value="transferencia" name="paymentOption"/>
      Transferencia electrónica
    </div>
    <div class="paymentOption">
      <g:radio id="dineromail" value="dineromail" name="paymentOption"/>
      Otros medios de pago
    </div>
  </div>
</div>
</body>
