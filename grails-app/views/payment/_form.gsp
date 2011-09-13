  <table width="100%">
    <tbody>
    <tr class="prop">
      <td valign="top" class="name">
        <label for="amount"><g:message code="payment.amount" default="Amount" />:</label>
      </td>
      <td valign="top" class="name">
        <g:textField name="amount" value="${payment.amount}"/>
      </td>
    </tr>
    <tr class="prop">
      <td valign="top" class="name">
        <label for="transactionId"><g:message code="payment.transaction" default="Transaction" />:</label>
      </td>
      <td valign="top" class="name">
        <g:textField name="transactionId" value="${payment.transactionId}"/>
      </td>
    </tr>
    <tr class="prop">
      <td valign="top" class="name">
        <label for="description"><g:message code="payment.description" default="Description" />:</label>
      </td>
      <td valign="top" class="name">
        <g:textField name="description" value="${payment.description}"/>
      </td>
    </tr>
    <tr class="prop">
      <td valign="top" class="name">
        <label for="paymentStatus"><g:message code="payment.paymentStatus" default="Payment Status" />:</label>
      </td>
      <td valign="top" class="name">
        <g:select name="paymentStatus" from="${com.synergyj.grain.course.PaymentStatus?.values()}" value="${payment?.paymentStatus}"  />
      </td>
    </tr>
    <tr class="prop">
      <td valign="top" class="name">
        <label for="kindOfPayment"><g:message code="payment.kindOfPayment" default="Kind Of Payment" />:</label>
      </td>
      <td valign="top" class="name">
        <g:select name="kindOfPayment" from="${com.synergyj.grain.course.KindOfPayment?.values()}" value="${payment?.kindOfPayment}"  />
      </td>
    </tr>
    <tr class="prop">
      <td valign="top" class="name">
        <label for="commission"><g:message code="payment.commission" default="Commission" />:</label>
      </td>
      <td valign="top" class="name">
        <g:textField name="commission" value="${payment.commission}"/>
      </td>
    </tr>
    <g:if test="${payment.paymentDate}">
    <tr>
      <td valign="top" class="name">
        <label for="paymentDate"><g:message code="payment.paymentDate" default="Payment Date" />:</label>
      </td>
      <td valign="top" class="name">
        <g:formatDate date="${payment.paymentDate}" format="EEEE dd/MM/yyyy hh:mm"/>
      </td>
    </tr>
    </g:if>
    </tbody>
  </table>
  <g:hiddenField name="id" value="${payment.id}"/>