    <%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.KindPromotion" %>

    <g:if test="${promotionsPerCourse}">
      <h3><g:message code="promotion.available"/></h3>
      <ul id="promotions" class="unstyled">
        <g:each in="${promotionsPerCourse}" var="promotionPerCourse">
          <g:set var="currentKindPromotion" value="${promotionPerCourse.promotion.kindPromotion}" />
          <g:if test="${currentKindPromotion == KindPromotion.GIFT}">
            <g:set var="isChecked" value="checked='checked'"/>
          </g:if>
          <g:else>
            <g:set var="isChecked" value=""/>
          </g:else>
          <li>
            <input type="checkbox" id="discount${promotionPerCourse.id}"
              style="<g:if test="${currentKindPromotion == KindPromotion.GIFT || currentKindPromotion == KindPromotion.COUPON}">display: none;</g:if>"
                name="discount" value="${promotionPerCourse.promotion.discount}" ${isChecked ?: ''} class='
                  <g:if test="${currentKindPromotion == KindPromotion.DISCOUNT}">select</g:if>
                    <g:if test="${currentKindPromotion == KindPromotion.COUPON}">coupon</g:if>' />
            <g:if test="${currentKindPromotion == KindPromotion.GIFT}">
					    <i class="icon-gift"></i>
            </g:if>
            <g:if test="${currentKindPromotion == KindPromotion.COUPON}">
					    <i class="icon-barcode"></i>
            </g:if>
            ${promotionPerCourse?.promotion?.description}
            <g:if test="${currentKindPromotion == KindPromotion.DISCOUNT}">
              <br/>
              <span id="messageForDiscount${promotionPerCourse.id}" class="label label-success" style="display: none;">
                Haz aplicado este descuento en tu registro
              </span>
            </g:if>
            <g:if test="${currentKindPromotion == KindPromotion.GIFT}">
              <span class="label label-success">Ya tienes esta promoción aplicada en tu registro</span>
            </g:if>
            <g:if test="${currentKindPromotion == KindPromotion.RECOMMENDATION}">
              <br/>Correo: <input type="text" name="emailFrom${promotionPerCourse.id}" size="30"/>
            </g:if>
            <g:if test="${currentKindPromotion == KindPromotion.COUPON}">
              <br/>Código: <input type="text" name="coupon${promotionPerCourse.id}" size="12"/>
              <a href="${createLink(controller: 'promotionPerScheduledCourse', action: 'checkCouponToRedeem', id: promotionPerCourse.id)}" id="checkCoupon${promotionPerCourse.id}" class="btn">
                <g:message code="promotion.coupon.apply"/>
              </a>
              <r:img uri="/images/spinner.gif" name="loader" style="display: none;" />
              <span id="messageForCoupon${promotionPerCourse.id}" class="label" style="display: none;">
              </span>
            </g:if>
          
          </li>
        </g:each>
      </ul>
    </g:if>
    <div id="needInvoice">
      <input type="checkbox" id="invoice" name="invoice"/>
      <g:message code="payment.needInvoice"/>&nbsp;<span class="label">Te solicitaremos tus datos después</span>
    </div>