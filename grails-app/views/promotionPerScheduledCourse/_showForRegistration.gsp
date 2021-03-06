<g:formRemote
  name="updatingPromotionsForRegistration"
  url="[controller:'promotionPerScheduledCourse',action:'updateForRegistration']"
  onSuccess="showResponse(data);">
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal">×</button>
  <h3>Promociones para <span id="promotionsForUser"></span></h3>
</div>
<div class="modal-body">

  <div class="alert alert-success" id="okMessage" style="display: none;">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Correcto!</strong> <span id="messageForOkStatus"></span>
  </div>

  <div class="alert alert-error" id="errorMessage" style="display: none;">
    <button class="close" data-dismiss="alert">×</button>
    <strong>Error!</strong> <span id="messageForErrorStatus"></span>
  </div>

  <g:hiddenField name="registrationId" value="${registration.id}"/>
  <table class="table table-condensed" id="payments">
    <thead>
      <tr>
        <th>&nbsp;</th>
        <th>Key</th>
        <th>Description</th>
        <th>Discount</th>
        <th>Kind of Promotion</th>
      </tr>
    </thead>
    <tbody>
    <g:each in="${promotionsForScheduledCourse}" var="promotionPerCourse">
      <tr id="promotionPerCourse${promotionPerCourse.id}">
        <g:set var="isPromotionActive" value="${false}"/>
        <g:findAll in="${registration.promotions*.promotion}" expr="it.id == promotionPerCourse?.promotion?.id">
          <g:set var="isPromotionActive" value="${true}"/>
        </g:findAll>
        <td><g:checkBox name="promotion${promotionPerCourse?.promotion?.id}" checked="${isPromotionActive}" /> </td>
        <td>${promotionPerCourse?.promotion}</td>
        <td>${promotionPerCourse?.promotion?.description}</td>
        <td>${promotionPerCourse?.promotion?.discount} %</td>
        <td>${promotionPerCourse?.promotion?.kindPromotion}</td>
      </tr>
    </g:each>
    </tbody>
  </table>
</div>

<div class="modal-footer">
  <g:submitButton class="btn btn-primary" name="updatePromotions" value="Actualizar"/>
  <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
</div>
</g:formRemote>