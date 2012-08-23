<div id="newPromotion" class="modal hide">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Add promotion to this course</h3>
  </div>
  <div class="modal-body">
    <g:formRemote name="addPromotionForm" url="[action:'addPromotion', id:scheduledCourseInstance.id]" onSuccess="addToPromotions(data)">
      <label for="promotion"><g:message code="promotionPerScheduledCourse.promotion" default="Promotion" />:</label>
      <g:select name="promotion.id" from="${promotions}" optionKey="id" value="${promotion?.id}"  />
      <label for="validUntil"><g:message code="promotionPerScheduledCourse.validUntil" default="Valid Until" />:</label>
      <g:datePicker name="validUntil" value="${promotionPerScheduledCourseInstance?.validUntil}"  />
      <r:script>
        $("select[id^=validUntil]").addClass("span1");
      </r:script>
    </g:formRemote>

    <table class="table table-condensed">
      <thead>
        <tr>
          <th>#</th>
          <th>Key</th>
          <th>Discount</th>
          <th>Kind</th>
        </tr>
      </thead>
      <tbody>
        <g:each in="${promotions}" var="promotion" status="i">  
          <tr id="promotionRowId${promotion.id}">
            <td>${i+1}</td>
            <td>${promotion.promotionKey} </td>
            <td>${promotion.discount}</td>
            <td>${promotion.kindPromotion}</td>
          </tr>
        </g:each>
      </tbody>
    </table>
  </div>
  <div class="modal-footer">
    <a id="addPromotion" href="#" class="btn btn-primary" >Agregar</a>
    <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  </div>
</div>