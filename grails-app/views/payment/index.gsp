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
        }else{
          $(this).siblings(":checkbox").attr('checked', false);
          $(this).parent().removeClass('check').addClass('uncheck');
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
      });
      $("p#reset").hide();
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
  <div id="breakdown">
    <g:render template="/registration/simpleShow" model="[registration:registration]"/>
  </div>
  <div style="clear: both;"></div>
  <div id="confirm">
    <g:link action="chooseForm" class="button">Págalo ahora</g:link>
    <p id="reset">
      <g:remoteLink action="resetPromotions" update="rightbox">Escoger de nuevo las promociones...</g:remoteLink>
    </p>
  </div>
</div>
<div id="right">
  <div id="rightbox">
    <g:render template="/promotion/showForPayment" model="[promotionsPerCourse:promotionsPerCourse]" />
  </div>
</div>
</body>
