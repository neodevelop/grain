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

  <table class="table table-condensed" id="payments">
    <thead>
        <tr>
          <th>#</th>
          <th>Amount</th>
          <th>Payment Date</th>
          <th>Status</th>
          <th>Kind of Payment</th>
          <th>&nbsp;</th>
        </tr>
      </thead>
      <tbody>
        <tr class="hide cloneable">
          <td><span title="paymentNumber"></span></td>
          <td><span title="paymentAmount"></span></td>
          <td><span title="paymentDate"></span></td>
          <td><span title="paymentStatus"></span></td>
          <td><span title="paymentKind"></span></td>
          <td>&nbsp;</td>
        </tr>
      <g:each in="${registration.payments}" var="payment" status="i">
        <tr id="payment${payment.id}">
          <td>${i+1}</td>
          <td>$ ${payment.amount}</td>
          <td><g:formatDate format="E dd-MM-yy" date="${payment?.paymentDate}"/></td>
          <td>${payment.paymentStatus}</td>
          <td>${payment.kindOfPayment}</td>
          <td>
            <div class="btn-group">
              <g:remoteLink class="btn btn-mini" controller="payment" action="showForEditAsync" update="editPayment" id="${payment.id}" onSuccess="showActionsForEdit()">
                Editar
              </g:remoteLink>
              <g:if test="${payment.paymentStatus == PaymentStatus.WAITING}">
                <g:remoteLink class="btn btn-mini btn-danger" id="${payment.id}" controller="payment" action="deleteAsync" onSuccess="paymentDeleted(data)">
                  Eliminar
                </g:remoteLink>
              </g:if>
              <g:if test="${payment.paymentStatus == PaymentStatus.PENDING}">
                <g:if test="${payment.kindOfPayment == KindOfPayment.SPEI}">
                  <a href="#" class="btn btn-mini btn-info" name="uploadReceipt${payment.id}">Subir recibo</a>
                </g:if>
                <g:else>
                  <button class="btn btn-mini btn-info">Comprobar en DM</button>
                </g:else>
              </g:if>
              <g:if test="${payment.paymentStatus == PaymentStatus.PAYED}">
                <button class="btn btn-mini btn-info">Ver recibo</button>
              </g:if>
            </div>
          </td>
        </tr>
      </g:each>
      </tbody>
  </table>

  <g:formRemote url="[controller:'payment',action:'updateAsync']" class="well form-horizontal" name="editPaymentForm" style="display:none;" onSuccess="paymentEditOk(data)">
    <fieldset>
      <div id="editPayment"></div>
      <div class="control-group">
        <label class="control-label"></label>
        <input class="btn btn-success" type="submit" value="Actualizar"/>
      </div>
    </fieldset>
  </g:formRemote>

  <g:form name="fileuploadForm" controller="payment" action="fileupload" method="POST" enctype="multipart/form-data" style="display:none;" class="well form-horizontal">
    <fieldset>
      <g:hiddenField name="paymentNumber" value=""/>
      <div class="control-group">
        <label class="control-label">Archivo:</label>
        <input id="file" type="file" name="file" class="file"/>
      </div>
      <div class="control-group">
        <label class="control-label"></label>
        <input value=". : Subir archivo : ." class="btn btn-success" type="submit" id="sendReceipt">
      </div>
      <div class="progress progress-striped active" id="loaderProgressBar" style="display: none;">
        <div style="width: 100%" class="bar"></div>
      </div>
    </fieldset>
  </g:form>

</div>

<div class="modal-footer">
  <a href="#" class="btn" onclick="hidePaymentForRegistration()">Cerrar</a>
  <g:remoteLink controller="payment" action="createAsync" class="btn btn-primary" id="${registration.id}" onSuccess="addPaymentToRegistration(data)">
    Agregar pago
  </g:remoteLink>
</div>