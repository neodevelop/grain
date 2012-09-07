<%@ page import="com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.PaymentService; com.synergyj.grain.course.RegistrationStatus" %>
  <table id="${tableName}" class="table table-condensed">
    <thead>
      <tr>
        <th><g:message code="login.username"/></th>
        <th><g:message code="payment.invoice"/></th>
        <th><g:message code="payment.amount"/></th>
        <th><g:message code="payment.commission"/></th>
        <th><g:message code="payment.quantity"/></th>
        <th><g:message code="payment.payment"/></th>
        <th><g:message code="payment.details"/></th>
      </tr>
    </thead>
    <tbody>
      <g:set var="totalPerGroup" value="${new BigDecimal(0)}"/>
      <g:each in="${registrationGroup}" var="registration">
        <g:set var="totalAmount" value="${new BigDecimal(0)}"/>
        <g:set var="totalCommission" value="${new BigDecimal(0)}"/>
        <g:each in="${registration?.payments}" var="payment">
          <g:set var="totalAmount" value="${totalAmount + payment.amount}"/>
          <g:set var="totalCommission" value="${totalCommission?.plus(payment?.commission ?: 0)}"/>
        </g:each>
        <g:set var="totalPerRegistration" value="${totalAmount - totalCommission}"/>
        <g:set var="totalPerGroup" value="${totalPerGroup + totalPerRegistration}"/>
      <tr id="student${registration?.id}" class="registration_${registration?.registrationStatus}">
        <td>${registration?.student?.email}</td>
        <td align="center"><g:formatBoolean boolean="${registration?.invoice}" true="Yes" false="No"/></td>
        <td align="center">$ <g:formatNumber number="${totalAmount}" locale="es_MX" format="\$ ###,##0.00"/></td>
        <td align="center">- $<g:formatNumber number="${totalCommission}" locale="es_MX" format="\$ ###,##0.00"/></td>
        <td align="center">${registration?.payments.size()}</td>
        <td align="center">$ <g:formatNumber number="${totalPerRegistration}" locale="es_MX" format="\$ ###,##0.00"/></td>
        <td align="center">
          <a href="#paymentsForRegistration${registration.id}" class="showDialog btn">
            <i class="icon-search"></i>
          </a>
        </td>
      </tr>
      </g:each>
      <tr class="totalPerGroup">
        <td colspan="8">
          Total del grupo: $ ${totalPerGroup}
        </td>
      </tr>
    </tbody>
  </table>
  
  <g:each in="${registrationGroup}" var="registration">
    <div id="paymentsForRegistration${registration.id}" title="Pagos de ${registration?.student?.email}" align="center">
        <table class="paymentsDetails table table-condensed">
          <thead>
            <tr>
              <th>${message(code:'payment.amount')}</th>
              <th>${message(code:'payment.commission')}</th>
              <th>${message(code:'payment.tx')}</th>
              <th>${message(code:'payment.paymentDate')}</th>
              <th>${message(code:'payment.description')}</th>
              <th>${message(code:'payment.status')}</th>
              <th>${message(code:'payment.kind')}</th>
            </tr>
          </thead>
          <tbody>
            <g:each in="${registration.payments}" var="payment">
            <tr>
              <td>$ <g:formatNumber number="${payment.amount}" locale="MX" format="#,###.00"/></td>
              <td>-$ <g:formatNumber number="${payment.commission}" locale="MX" format="#,###.00"/></td>
              <td>${payment.transactionId}</td>
              <td><g:formatDate date="${payment.paymentDate}" format="dd/MM/yy hh:mm a"/></td>
              <td>${payment.description}</td>
              <td>${payment.paymentStatus}</td>
              <td>${payment.kindOfPayment}</td>
            </tr>
            </g:each>
          </tbody>
        </table>
    </div>
  </g:each>