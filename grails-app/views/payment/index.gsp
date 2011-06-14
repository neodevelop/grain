8<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.info', default: 'Payment info')}"/>
  <g:javascript>
    $(function(){
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
        $(this).toggleClass('check');
        $(this).toggleClass('uncheck');
      });
    });

    function isValidEmailAddress(emailAddress) {
      var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
      return pattern.test(emailAddress);
    }

    function enabledCheckboxes(){
      $(":checkbox").attr("disabled",false);
    }
  </g:javascript>
</head>
<body>
<div id="left">
  <g:render template="/registration/simpleShow" model="[registration:registration]"/>
</div>
<div id="right">
  <div id="rightbox">
    <h1>Promotions for this course</h1>
    <g:formRemote name="recalculate" url="[action:'recalculate']" update="left" before="enabledCheckboxes()">
    <g:if test="promotionsPerCourse">
      <h2>Estas son las promociones disponibles para ti</h2>
      <ul id="promotions">
        <g:each in="${promotionsPerCourse}" var="promotionPerCourse">
          <g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.GIFT}">
            <g:set var="isChecked" value="checked='checked'"/>
          </g:if>
          <g:else>
            <g:set var="isChecked" value=""/>
          </g:else>
          <li class='<g:if test="${isChecked}">check</g:if><g:else>uncheck</g:else><g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.DISCOUNT}"> select</g:if>' >
          <input type="checkbox" id="discount" name="discount" value="${promotionPerCourse.id}" ${isChecked ?: ''} style="display:none;" />
					${promotionPerCourse?.promotion?.description}
          <g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.RECOMMENDATION}">
            <br/>Correo: <input type="text" name="emailFrom${promotionPerCourse.id}" size="30"/>
          </g:if>
          </li>
        </g:each>
      </ul>
    </g:if>
    <input type="checkbox" id="invoice" name="invoice"/> Necesitaré factura
    <div style="clear: both;"></div>
    <input type="submit" value="Aprovechar estas promociones" name="recalc" />
    </g:formRemote>
    <div style="clear: both;"></div>
  </div>
</div>
</body>
