<div class="control-group">
  <label for="amount" class="control-label"><g:message code="payment.amount" default="Amount" />:</label>
  <div class="input-prepend">
    <span class="add-on">$</span>
    <g:textField name="amount" value="${payment.amount}" class="input-mini"/>
  </div>
</div>

<div class="control-group">
  <label for="commission" class="control-label"><g:message code="payment.commission" default="Commission" />:</label>
  <div class="input-prepend">
    <span class="add-on">$</span>
    <g:textField name="commission" value="${payment.commission}" class="input-mini"/>
  </div>
</div>

<div class="control-group">
  <label for="transactionId" class="control-label"><g:message code="payment.transaction" default="Transaction" />:</label>
  <g:textField name="transactionId" value="${payment.transactionId}"/>
</div>

<div class="control-group">
  <label for="description" class="control-label"><g:message code="payment.description" default="Description" />:</label>
  <g:textField name="description" value="${payment.description}"/>
</div>

<div class="control-group">
  <label for="paymentStatus" class="control-label"><g:message code="payment.paymentStatus" default="Payment Status" />:</label>
  <g:select name="paymentStatus" from="${com.synergyj.grain.course.PaymentStatus?.values()}" value="${payment?.paymentStatus}" class="input-medium" />
</div>

<div class="control-group">
  <label for="kindOfPayment" class="control-label"><g:message code="payment.kindOfPayment" default="Kind Of Payment" />:</label>
  <g:select name="kindOfPayment" from="${com.synergyj.grain.course.KindOfPayment?.values()}" value="${payment?.kindOfPayment}" class="input-medium" />
</div>

<g:if test="${payment.paymentDate}">
  <div class="control-group">
    <label class="control-label"><g:message code="payment.paymentDate" default="Payment Date" />:</label>
    <span class="input-xlarge uneditable-input">
      <g:formatDate date="${payment.paymentDate}" format="EEEE dd/MM/yyyy hh:mm"/>
    </span>
  </div>
</g:if>

<g:hiddenField name="id" value="${payment.id}"/>
