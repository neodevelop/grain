<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.info', default: 'Payment info')}"/>
  <g:javascript>
    $(function(){
      var totalDiscount = 0;
      var totalPayment = $(":input[name:'totalAmount']").val();
      var totalPaymentWithDiscount = totalPayment;

      $("div#tabs").tabs();

      $(":checkbox[name*='discount']").change(function(){
        if(!$(this).is(":checked")){
          $("div#withDiscount").hide();
        }
        totalDiscount = 0;
        $(":checked[name*='discount']").each(function(){
          $("div#withDiscount").show();
          var id = $(this).attr("id").substring(8);
          var kind = $("input[name='kindPromotion"+id+"']").val();
          if(kind=='DISCOUNT'){
            totalDiscount += ($(this).val()*1);
          }
          if(kind=='GIFT'){
            // Todo confirmar el regalo con alguna imagen
          }
          if(kind=='RECOMMENDATION'){
            totalDiscount += ($(this).val()*1);

          }
        });
        totalPaymentWithDiscount = (totalPayment*(1-(totalDiscount*.01)));
        $("div#withDiscount > h3 > span#priceWithDiscount").html(" "+ totalPaymentWithDiscount );
        if($(":checkbox[name='needInvoice']").is(":checked")){
          calculateIva(totalPaymentWithDiscount);
        }else{
          $("span#finalAmount").html("$ "+ totalPaymentWithDiscount );
        }
      });

      $(":checkbox[name='needInvoice']").change(function(){
        if($(this).is(':checked')){
          // Se agrega el IVA
          calculateIva(totalPaymentWithDiscount);
          $("div#invoice").show();
        }else{
          // Se muestra la cantidad original
          $("span#finalAmount").html("$ "+ totalPaymentWithDiscount );
          $("div#invoice").hide();
        }
      });

    });

    function calculateIva(totalPaymentNoIva){
      $('span#IVA').html("$ " + (totalPaymentNoIva * 0.16));
      var totalPaymentPlusIva = totalPaymentNoIva * 1.16;
      totalPaymentPlusIva = Math.round(totalPaymentPlusIva)
      $("span#finalAmount").html("$ "+ totalPaymentPlusIva );
    }
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
  <h4>Original Price:</h4>
  <h3>
      $ ${registration.scheduledCourse.costByCourse}
  </h3>
  <div id="withDiscount" style="display:none;">
  <h4>Price with discount:</h4>
  <h3>
      $ <span id="priceWithDiscount">${registration.scheduledCourse.costByCourse}</span>
  </h3>
  </div>
  <div id="invoice" style="display: none;">
    <h5>IVA: $ <span id="IVA">${registration.scheduledCourse.costByCourse * 0.16}</span></h5>
  </div>
  <h2>Final price:</h2>
  <h1>
    <span id="finalAmount">
      ${registration.scheduledCourse.costByCourse}
    </span>
    <g:hiddenField name="totalAmount" value="${registration.scheduledCourse.costByCourse}"/>
  </h1>
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
            <ul id="extraInfo${i}" class="extraInfo">
              <li>Válido hasta: <g:formatDate date="${promotionPerCourse.validUntil}" format="dd-MM-yy"/></li>
              <g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.RECOMMENDATION}">
                <li>
                  Email de la persona que te recomienda<br/>
                  <g:textField name="recommendationFrom"/>
                </li>
              </g:if>
            </ul>
            </g:if>
          </g:each>
          <li>
            <g:checkBox name="needInvoice" checked="false"/><i>Necesitarás factura?</i>
          </li>
        </ul>
      </div>
      </g:formRemote>
  </div>
</div>
</body>
