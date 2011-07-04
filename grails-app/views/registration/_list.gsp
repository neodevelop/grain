<%@ page import="com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.RegistrationStatus" %>
<g:each in="${registrationList}" var="registration">
  <table class="registration" cellpadding="0" cellspacing="0">
    <tr class="title">
      <td class="titleLeft">
        ${registration.scheduledCourse.course}
      </td>
      <td class="titleRight">
        ${registration.scheduledCourse.course.courseKey}
      </td>
    </tr>
    <tr class="content">
      <td class="contentLeft">
        <img src="${createLinkTo(dir:'themes/wb/images',file:'icon_calendar.png')}" alt="calendar" width="24px" height="24px"/>
        <g:message code="registration.date"/>: <g:formatDate date="${registration.dateCreated}" format="EEEE dd-MM-yyyy"/>
      </td>
      <td class="contentRight">
        <g:if test="${registration.registrationStatus == RegistrationStatus.REGISTERED}">
          <g:message code="registration.registered"/>
          <img src="${createLinkTo(dir:'themes/wb/icon',file:'valid-blue.png')}" alt="valid"/>
        </g:if>
        <g:if test="${registration.registrationStatus == RegistrationStatus.PENDING_PAYMENT}">
          <g:message code="registration.pending"/>
          <img src="${createLinkTo(dir:'themes/wb/icon',file:'attention.png')}" alt="valid"/>
        </g:if>
        <g:if test="${registration.registrationStatus == RegistrationStatus.PAYED}">
          <g:message code="registration.payed"/>
          <img src="${createLinkTo(dir:'themes/wb/icon',file:'valid-green.png')}" alt="valid"/>
        </g:if>
      </td>
    </tr>

    <tr class="content">
      <td class="contentLeft">
        <img src="${createLinkTo(dir:'themes/wb/images',file:'icon_calendar.png')}" alt="calendar" width="24px" height="24px"/>
        <g:message code="registration.beginDate"/>: <g:formatDate date="${registration.scheduledCourse.beginDate}" format="EEEE dd-MM-yyyy"/>
      </td>
      <td class="contentRight">
        &nbsp;
      </td>
    </tr>


    <g:if test="${registration.registrationStatus == RegistrationStatus.REGISTERED}">
    <tr class="content">
      <td class="contentLeft">
        <img src="${createLinkTo(dir:'themes/wb/images',file:'icon_calendar.png')}" alt="calendar" width="24px" height="24px"/>
        <g:message code="registration.limitDate"/>: <g:formatDate date="${registration.scheduledCourse.limitRegistrationDate}" format="EEEE dd-MM-yyyy"/>
      </td>
      <td class="contentRight money">
        <g:message code="registration.cost"/>: $ ${registration.scheduledCourse.costByCourse}
        <img src="${createLinkTo(dir:'themes/wb/icon',file:'money.png')}" alt="money" width="32px" height="32px"/>
      </td>
    </tr>

    <tr>
      <td colspan="2" class="cellCenter">
        <g:link mapping="payment" class="action">
          <g:message code="payment.payit"/>
        </g:link>
      </td>
    </tr>
    </g:if>

    <g:if test="${registration.registrationStatus == RegistrationStatus.PENDING_PAYMENT}">
    <tr>
      <td colspan="2" class="paymentSection">
        <g:message code="course.payments"/>
      </td>
    </tr>

    <tr class="paymentTitle">
      <td colspan="2" class="payments">
        <table class="paymentDetail" cellpadding="5" cellspacing="0">
          <thead>
            <tr>
              <th># <g:message code="payment.payment"/></th>
              <th><g:message code="payment.amount"/></th>
              <th><g:message code="payment.message"/></th>
              <th><g:message code="payment.action"/></th>
            </tr>
          </thead>
          <tbody>
          <g:each in="${registration.payments.sort()}" var="payment" status="i">
          <tr class="paymentRow">
            <td># ${i+1}</td>
            <td class="money">$ ${payment.amount}</td>

            <g:if test="${payment.paymentStatus == PaymentStatus.WAITING}">
              <td>
                <g:message code="payment.waiting"/>
              </td>
              <td valign="center">
                <g:link controller="payment" action="start" id="${payment.id}">
                  <g:message code="payment.startPayment"/>
                </g:link>
              </td>
            </g:if>

            <g:if test="${payment.paymentStatus == PaymentStatus.PENDING}">
              <g:if test="${payment.receipts.size()}">
                <td>
                  <g:message code="payment.pendingReview"/>
                </td>
              </g:if>
              <g:else>
                <td><g:message code="payment.pendingUpload"/></td>
              </g:else>
              <g:if test="${payment.kindOfPayment == KindOfPayment.SPEI}">
                <td>
                  <g:if test="${payment.receipts.size()}">
                    <g:message code="payment.waitProcess"/>
                  </g:if>
                  <g:else>
                    <g:link controller="payment" action="uploadReceipt" name="uploadReceipt${payment.id}">
                      <g:message code="payment.uploadReceipt"/>
                    </g:link>
                  </g:else>
                </td>
              </g:if>
              <g:if test="${payment.kindOfPayment == KindOfPayment.DINERO_MAIL}">
                <td><g:message code="payment.waitProcess"/></td>
              </g:if>
            </g:if>

            <g:if test="${payment.paymentStatus == PaymentStatus.PAYED}">
              <td><g:message code="payment.payed"/></td>
              <g:if test="${payment.kindOfPayment == KindOfPayment.SPEI}">
                <td>
                  <g:message code="payment.thanks"/>
                </td>
              </g:if>
              <g:else>
                <td>&nbsp;</td>
              </g:else>
            </g:if>
            <g:if test="${payment.paymentStatus == PaymentStatus.CANCELLED}">
              <td><g:message code="payment.cancelled"/></td>
              <td>&nbsp;</td>
            </g:if>
            <g:if test="${payment.paymentStatus == PaymentStatus.REFUND}">
              <td><g:message code="payment.refund"/></td>
              <td>&nbsp;</td>
            </g:if>
          </g:each>
          </tbody>
        </table>
      </td>
    </tr>
    <g:javascript>
      $("table.paymentDetail").styleTable();
    </g:javascript>
    </g:if>

  </table>
</g:each>