    <%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.KindPromotion" %>

    <g:if test="${promotionsPerCourse}">
      <h2><g:message code="promotion.available"/></h2>
      <ul id="promotions">
        <g:each in="${promotionsPerCourse}" var="promotionPerCourse">
          <g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.GIFT}">
            <g:set var="isChecked" value="checked='checked'"/>
          </g:if>
          <g:else>
            <g:set var="isChecked" value=""/>
          </g:else>
          <li class='<g:if test="${isChecked}">check</g:if><g:else>uncheck</g:else>
          <g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.DISCOUNT}">select</g:if>
          <g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.COUPON}">coupon</g:if>'>
            <span class="option<g:if test="${isChecked}">Check</g:if><g:else>Uncheck</g:else>"></span>
            <input type="checkbox" id="discount${promotionPerCourse.id}" name="discount" value="${promotionPerCourse.promotion.discount}" ${isChecked ?: ''} style="display:none;" />
					  ${promotionPerCourse?.promotion?.description}
            <g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.RECOMMENDATION}">
              <br/>Correo: <input type="text" name="emailFrom${promotionPerCourse.id}" size="30"/>
            </g:if>
            <g:if test="${promotionPerCourse.promotion.kindPromotion == KindPromotion.COUPON}">
              <br/><br/>Código: <input type="text" name="coupon${promotionPerCourse.id}" size="12"/>
              <a href="${createLink(controller: 'promotionPerScheduledCourse', action: 'checkCouponToRedeem', id: promotionPerCourse.id)}" id="checkCoupon${promotionPerCourse.id}">
                <g:message code="promotion.coupon.apply"/>
              </a>
              <img src="${resource(dir:'themes/wb/images',file: 'spinner.gif')}" name="loader" style="display: none;" />
              <div id="messageForCoupon${promotionPerCourse.id}" style="display: none;"></div>
              <br/><br/>
            </g:if>
          </li>
        </g:each>
      </ul>
    </g:if>
    <div id="needInvoice">
      <input type="checkbox" id="invoice" name="invoice"/>
      <g:message code="payment.needInvoice"/>
    </div>