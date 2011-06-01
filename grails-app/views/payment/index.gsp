<%@ page import="com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.info', default: 'Payment info')}"/>
  <g:javascript>
    $(function(){
      $("div#tabs").tabs();
      var totalAmount = $(":input[name:'totalAmount']").val();
      $(":checkbox[name*='discount']").change(function(){
        var totalDiscount = 0;
        $(":checked[name*='discount']").each(function(){
          var id = $(this).attr("id").substring(8);
          var kind = $("input[name='kindPromotion"+id+"']").val();
          if(kind=='DISCOUNT'){
            totalDiscount += ($(this).val()*1);
          }
          if(kind=='GIFT'){
            // Todo confirmar el regalo con alguna imagen
          }
        });
        $("span#finalAmount").html("$ "+ (totalAmount*(1-(totalDiscount*.01))));
      });
    });
  </g:javascript>
</head>
<body>

<div id="left">
  <h4>Course:</h4>
  <h3>${registration.scheduledCourse.course}</h3>
  <br>
  <h4>Registration on:</h4>
  <h3><g:formatDate date="${registration.registrationDate}" format="EEEE dd-MMMM-yyyy"/></h3>
  <br>
  <h4>Price:</h4>
  <h3>
    <span id="finalAmount">
      $ ${registration.scheduledCourse.costByCourse}
    </span>
    <g:hiddenField name="totalAmount" value="${registration.scheduledCourse.costByCourse}"/>
  </h3>
  <h5>IVA: $ <span id="IVA">${registration.scheduledCourse.costByCourse * 0.16}</span></h5>
  <h2>Total:</h2>
  <h1>${registration.scheduledCourse.costByCourse * 1.16}</h1>
  <br>

</div>
<div id="right">
  <div id="tabs" style="width:450px;">
      <ul>
        <li><a href="#tabs-1">Promotions for this course</a></li>
      </ul>
      <g:formRemote name="calculateAmount" url="[action:'calculateAmount',controller:'payment']">
      <div id="tabs-1">
        <ul id="promotions">
          <g:each in="${promotionsPerCourse}" var="promotionPerCourse" status="i">
            <g:if test="${promotionPerCourse.hasNotExpired() }">
            <li>
              <g:checkBox name="discount${i}" value="${promotionPerCourse.promotion.discount}" checked="false"/>
              <g:hiddenField name="kindPromotion${i}" value="${promotionPerCourse.promotion.kindPromotion}"/>
              ${promotionPerCourse.promotion.description}
            </li>
            <ul class="validUntil">
              <li>Válido hasta: <g:formatDate date="${promotionPerCourse.validUntil}" format="dd-MM-yy"/></li>
            </ul>
            </g:if>
          </g:each>
        </ul>
      </div>
      </g:formRemote>
  </div>
</div>
</body>
