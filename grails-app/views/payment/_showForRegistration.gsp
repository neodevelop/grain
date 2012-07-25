<%@ page import="com.synergyj.grain.course.Payment; com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus" %>
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal">×</button>
  <h3>Pagos de ${registration.student.email}</h3>
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

  <g:render template="tableDetail" model="[registration:registration]" />

  <g:formRemote url="[controller:'payment',action:'updateAsync']" class="well form-horizontal" name="editPaymentForm" style="display:none;" onSuccess="paymentEditOk(data)">
    <fieldset>
      <div id="editPayment"></div>
      <div class="control-group">
        <label class="control-label"></label>
        <input class="btn btn-success" type="submit" value="Actualizar"/>
      </div>
    </fieldset>
  </g:formRemote>

  <g:render template="fileUpload" />

</div>

<div class="modal-footer">
  <a href="#" class="btn" onclick="hidePaymentForRegistration()">Cerrar</a>
  <g:remoteLink controller="payment" action="createAsync" class="btn btn-primary" id="${registration.id}" onSuccess="addPaymentToRegistration(data)">
    Agregar pago
  </g:remoteLink>
</div>