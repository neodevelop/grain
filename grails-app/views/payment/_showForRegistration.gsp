<%@ page import="com.synergyj.grain.course.Payment; com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus" %>
<div class="modal-header">
  <button type="button" class="close" data-dismiss="modal">×</button>
  <h3>Pagos de ${registration.student.email}</h3>
</div>
<div class="modal-body">
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
          <td><button class="btn btn-mini">Editar</button></td>
        </tr>
      <g:each in="${registration.payments}" var="payment" status="i">
        <tr>
          <td>${i+1}</td>
          <td>$ ${payment.amount}</td>
          <td><g:formatDate format="E dd-MM-yy" date="${payment?.paymentDate}"/></td>
          <td>${payment.paymentStatus}</td>
          <td>${payment.kindOfPayment}</td>
          <td>
            <div class="btn-group">
              <g:remoteLink class="btn btn-mini" controller="payment" action="showForEditAsync" update="editPayment" id="${payment.id}">
                Editar
              </g:remoteLink>
              <g:if test="${payment.paymentStatus == PaymentStatus.PENDING}">
                <g:if test="${payment.kindOfPayment == KindOfPayment.SPEI}">
                  <button class="btn btn-mini btn-info">Subir recibo</button>
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
  <g:form controller="payment" action="updateAsync" class="well form-horizontal">
    <fieldset>
      <div id="editPayment">
        
      </div>
    <div class="form-actions">
      <button class="btn btn-primary" type="submit">Save changes</button>
      <button class="btn">Cancel</button>
    </div>
    </fieldset>
  </g:form>
  </div>
</div>
<div class="modal-footer">
  <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  <g:remoteLink controller="payment" action="createAsync" class="btn btn-primary" id="${registration.id}" onSuccess="addPaymentToRegistration(data)">
    Agregar pago
  </g:remoteLink>
</div>