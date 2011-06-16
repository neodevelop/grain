  <%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.KindPromotion" %>
    <h1>Promotions for this course</h1>
    <g:formRemote name="recalculate" url="[action:'recalculate']" update="breakdown" onSuccess="disabledOptions()">
    <g:if test="${promotionsPerCourse}">
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
    <div id="needInvoice">
      <input type="checkbox" id="invoice" name="invoice"/> Necesitaré factura
    </div>
    <div id="applyPromotions" align="center">
      <input type="submit" value="Aprovechar estas promociones" name="recalc" />
    </div>
    </g:formRemote>
    <div style="clear: both;"></div>

    <g:if test="${resetPromotions}">
      <script type="text/javascript">
        startOver();
      </script>
    </g:if>