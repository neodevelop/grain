<%@ page import="com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.PaymentService; com.synergyj.grain.course.RegistrationStatus" %>
  <table id="${tableName}" cellpadding="5px" cellspacing="0" width="100%">
    <thead>
      <tr>
        <th><g:message code="login.username"/></th>
        <th><g:message code="payment.invoice"/></th>
        <th><g:message code="payment.amount"/></th>
        <th><g:message code="payment.commission"/></th>
        <th><g:message code="payment.quantity"/></th>
        <th><g:message code="payment.payment"/></th>
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
      <tr id="student${registration?.id}" class="registration_${registration?.registrationStatus}">
        <td>${registration?.student?.email}</td>
        <td><g:formatBoolean boolean="${registration?.invoice}" true="Yes" false="No"/></td>
        <td>$ <g:formatNumber number="${totalAmount}" format="#,###.00" locale="MX"/></td>
        <td>- $<g:formatNumber number="${totalCommission}" format="#,###.00" locale="MX"/></td>
        <td>${registration?.payments.size()}</td>
        <td>$ <g:formatNumber number="${totalPerRegistration}" format="#,###.00" locale="MX"/></td>
      </tr>
      </g:each>
    </tbody>
  </table>