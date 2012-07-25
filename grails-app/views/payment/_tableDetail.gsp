  <%@ page import="com.synergyj.grain.course.Payment; com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus" %>
  <table class="table table-condensed" id="payments">
    <thead>
        <tr>
          <th>#</th>
          <th><g:message code="payment.amount" default="Amount"/></th>
          <th><g:message code="payment.paymentDate" default="Payment Date"/></th>
          <th><g:message code="payment.status" default="Status"/></th>
          <th><g:message code="payment.kind" default="Kind of Payment"/></th>
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
      <g:each in="${registration.payments.sort()}" var="payment" status="i">
        <tr id="payment${payment.id}">
          <td>${i+1}</td>
          <td>$ ${payment.amount}</td>
          <td><g:formatDate format="E dd-MM-yy" date="${payment?.paymentDate}"/></td>
          <td>${g.message(code:payment?.paymentStatus?.code)}</td>
          <td>${payment.kindOfPayment}</td>
          <td>
            <div class="btn-group">
              
              <sec:ifAnyGranted roles="ROLE_ADMIN">
              <g:remoteLink class="btn btn-mini" controller="payment" action="showForEditAsync" update="editPayment" id="${payment.id}" onSuccess="showActionsForEdit()">
                Editar
              </g:remoteLink>
              <g:if test="${payment.paymentStatus == PaymentStatus.WAITING}">
                <g:remoteLink class="btn btn-mini btn-danger" id="${payment.id}" controller="payment" action="deleteAsync" onSuccess="paymentDeleted(data)">
                  Eliminar
                </g:remoteLink>
              </g:if>
              </sec:ifAnyGranted>

              <g:if test="${payment.paymentStatus == PaymentStatus.PENDING}">
                <g:if test="${payment.kindOfPayment == KindOfPayment.SPEI}">
                  <g:if test="${payment.receipts.size()}">
                    <g:each in="${payment.receipts}" var="receipt">
                      <a href="${receipt.url()}" target="_blank" class="btn btn-mini btn-info"><i class="icon-file"></i></a>
                      <sec:ifAnyGranted roles="ROLE_ADMIN">
                      <g:remoteLink class="btn btn-mini btn-success" controller="receipt" action="approve" id="${receipt.id}" onSuccess="showResponse(data)" onComplete="hideButtons(${payment.id})">
                        <i class="icon-ok"></i>
                      </g:remoteLink>
                      <g:remoteLink class="btn btn-mini btn-danger" controller="receipt" action="delete" id="${receipt.id}" onSuccess="showResponse(data)" onComplete="hideButtons(${payment.id})">
                        <i class="icon-remove"></i>
                      </g:remoteLink>
                      </sec:ifAnyGranted>
                    </g:each>
                  </g:if>
                  <g:else>
                    <a href="#" class="btn btn-mini btn-info" name="uploadReceipt${payment.id}">Subir recibo</a>
                  </g:else>
                </g:if>
                <g:else>
                  <sec:ifAllGranted roles="ROLE_ADMIN">
                  <g:remoteLink class="btn btn-mini btn-info" controller="receipt" action="approveDineroMail" id="${payment.id}" params="[registrationId:registration.id]" onSuccess="showResponse(data)" onComplete="hideButtons(${payment.id})">
                    Comprobar en DM
                  </g:remoteLink>
                  </sec:ifAllGranted>
                  <sec:ifNotGranted roles="ROLE_ADMIN">
                    <span class="label label-info">Procesando pago</span>
                  </sec:ifNotGranted>
                </g:else>
              </g:if>
              <g:if test="${payment.paymentStatus == PaymentStatus.PAYED}">
                  <g:if test="${payment.receipts.size()}">
                    <g:each in="${payment.receipts}" var="receipt">
                      <a href="${receipt.url()}" target="_blank" class="btn btn-mini btn-info"><i class="icon-file"></i></a>
                    </g:each>
                  </g:if>
              </g:if>
            </div>
          </td>
        </tr>
      </g:each>
      </tbody>
  </table>