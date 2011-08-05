<%@ page import="com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.PaymentService; com.synergyj.grain.course.RegistrationStatus" %>
  <table id="${tableName}" cellpadding="5px" cellspacing="0" width="100%">
    <thead>
      <tr>
        <th><g:message code="login.username"/></th>
        <th><g:message code="me.name"/></th>
        <th>&nbsp;</th>
        <th><g:message code="registration.status" default="Status"/></th>
        <th><g:message code="registration.invoice" default="Invoice"/></th>
        <th><g:message code="promotion.name"/></th>
        <th><g:message code="payment.payment"/></th>
      </tr>
    </thead>
    <tbody>
      <g:set var="totalPerGroup" value="${new BigDecimal(0)}"/>
      <g:each in="${registrationGroup}" var="registration">
      <tr id="student${registration?.student?.id}" class="registration_${registration?.registrationStatus}">
        <td>${registration?.student?.email}</td>
        <td>${registration?.student?.firstName} ${registration?.student?.lastName}</td>
        <td>
          <g:remoteLink controller="studentsGroup" action="${action}" id="${registration?.student?.id}" params="[studentsGroupId:studentsGroup?.id]" onSuccess="${action}(${registration?.student?.id})">
            <g:message code="studentsGroup.move" />
          </g:remoteLink>
        </td>
        <td>
          <g:if test="${registration?.registrationStatus == RegistrationStatus.REGISTERED}">

            Generar pago

          </g:if>
          <g:else>
            ${registration.registrationStatus}
          </g:else>
        </td>
        <td>
          <g:formatBoolean boolean="${registration?.invoice}" true="Yes" false="No"/>
        </td>
        <td>
          <table id="promotionsForRegistration${registration?.id}" border="1">
            <g:each in="${registration?.promotions}" var="promotionPerRegistration">
            <tr>
              <td>${promotionPerRegistration?.promotion}</td>
            </tr>
            </g:each>
          </table>
        </td>
        <td>
          <table id="paymentsForRegistration${registration?.id}" border="0" cellpadding="2px">
            <g:set var="totalAmount" value="${new BigDecimal(0)}"/>
            <g:set var="totalCommission" value="${new BigDecimal(0)}"/>
            <g:each in="${registration?.payments}" var="payment">
            <tr>
              <td>${payment?.paymentStatus}</td>
              <td>${payment?.kindOfPayment}</td>
              <td>$ ${payment?.amount}</td>
              <td>-$ ${payment?.commission}</td>
              <td>
                <g:if test="${payment?.kindOfPayment == KindOfPayment.DINERO_MAIL}">
                  Aprobar pago
                </g:if>
                <g:else>
                  <g:if test="${payment.paymentStatus == PaymentStatus.WAITING}">
                    Comenzar pago
                  </g:if>
                  <g:if test="${payment.paymentStatus == PaymentStatus.PENDING}">
                    Subir recibo
                  </g:if>
                </g:else>
                &nbsp;
              </td>
            </tr>
            <g:set var="totalAmount" value="${totalAmount + payment.amount}"/>
            <g:set var="totalCommission" value="${totalCommission?.plus(payment?.commission ?: 0)}"/>
            </g:each>
          </table>
        </td>
        <td>
          <g:set var="totalPerRegistration" value="${totalAmount - totalCommission}"/>
          $ ${ totalPerRegistration }
          <g:set var="totalPerGroup" value="${totalPerGroup + totalPerRegistration}"/>
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