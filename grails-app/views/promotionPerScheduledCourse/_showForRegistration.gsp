<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal">×</button>
  <h3>Promociones para <span id="promotionsForUser">fulanito</span></h3>
</div>
<div class="modal-body">
  <table class="table table-condensed" id="payments">
    <thead>
      <tr>
        <th>&nbsp;</th>
        <th>Key</th>
        <th>Description</th>
        <th>Discount</th>
        <th>Kind of Promotion</th>
        <th>&nbsp;</th>
      </tr>
    </thead>
    <tbody>
    <g:each in="${promotionsForScheduledCourse}" var="promotionPerCourse">
      <tr id="promotionPerCourse${promotionPerCourse.id}">
        <g:set var="isPromotionActive" value="${false}"/>
        <g:findAll in="${promotionsInRegistration}" expr="it.id == promotionPerCourse?.promotion?.id">
          <g:set var="isPromotionActive" value="${true}"/>
        </g:findAll>
        <td><g:checkBox name="promotion${promotionPerCourse?.promotion?.id}" checked="${isPromotionActive}" /> </td>
        <td>${promotionPerCourse?.promotion}</td>
        <td>${promotionPerCourse?.promotion?.description}</td>
        <td>${promotionPerCourse?.promotion?.discount} %</td>
        <td>${promotionPerCourse?.promotion?.kindPromotion}</td>
        <td>&nbsp;</td>
      </tr>
    </g:each>
    </tbody>
  </table>
</div>

<div class="modal-footer">
  <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
</div>