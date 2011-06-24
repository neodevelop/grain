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
        Registration: <g:formatDate date="${registration.dateCreated}" format="EEEE dd-MM-yyyy"/>
      </td>
      <td class="contentRight">
        ${registration.registrationStatus}
        <img src="${createLinkTo(dir:'themes/wb/icon',file:'valid-blue.png')}" alt="valid"/>
      </td>
    </tr>

    <tr class="content">
      <td class="contentLeft">
        <img src="${createLinkTo(dir:'themes/wb/images',file:'icon_calendar.png')}" alt="calendar" width="24px" height="24px"/>
        Begin date: <g:formatDate date="${registration.scheduledCourse.beginDate}" format="EEEE dd-MM-yyyy"/>
      </td>
      <td class="contentRight">
        &nbsp;
      </td>
    </tr>


    <g:if test="${registration.registrationStatus == RegistrationStatus.REGISTERED}">
    <tr class="content">
      <td class="contentLeft">
        <img src="${createLinkTo(dir:'themes/wb/images',file:'icon_calendar.png')}" alt="calendar" width="24px" height="24px"/>
        Limit registration: <g:formatDate date="${registration.scheduledCourse.limitRegistrationDate}" format="EEEE dd-MM-yyyy"/>
      </td>
      <td class="contentRight money">
        Cost: $ ${registration.scheduledCourse.costByCourse}
        <img src="${createLinkTo(dir:'themes/wb/icon',file:'money.png')}" alt="money" width="32px" height="32px"/>
      </td>
    </tr>

    <tr>
      <td colspan="2" class="cellCenter">
        <g:link mapping="payment" class="action">Págalo y aprovecha nuestras promociones</g:link>
      </td>
    </tr>
    </g:if>

    <g:if test="${registration.registrationStatus == RegistrationStatus.PENDING_PAYMENT}">
    <tr>
      <td colspan="2" class="cellCenter">
        Pagos del curso
      </td>
    </tr>

    <tr class="paymentTitle">
      <td colspan="2" class="cellCenter">
        <table class="paymentDetail">
          <g:each in="${registration.payments.sort()}" var="payment" status="i">
          <tr class="paymentRow">
            <td>Payment # ${i+1}</td>
            <td>$ ${payment.amount}</td>

            <g:if test="${payment.paymentStatus == PaymentStatus.WAITING}">
              <td>Deseo hacer este pago ahora...</td>
              <td>Iniciar</td>
            </g:if>
            <g:if test="${payment.paymentStatus == PaymentStatus.PENDING}">
              <g:if test="${payment.receipts.size()}">
                <td>Estamos procesando tu pago</td>
              </g:if>
              <g:else>
                <td>Estamos en espera de confirmación</td>
              </g:else>
              <g:if test="${payment.kindOfPayment == KindOfPayment.SPEI}">
                <td>Subir recibo</td>
              </g:if>
              <g:if test="${payment.kindOfPayment == KindOfPayment.DINERO_MAIL}">
                <td>En espera del procesamiento</td>
              </g:if>
            </g:if>
            <g:if test="${payment.paymentStatus == PaymentStatus.PAYED}">
              <td>Pagado</td>
              <td>Ver recibo si SPEI</td>
            </g:if>
            <g:if test="${payment.paymentStatus == PaymentStatus.CANCELLED}">
              <td>Pago cancelado</td>
              <td>Imagen</td>
            </g:if>
            <g:if test="${payment.paymentStatus == PaymentStatus.REFUND}">
              <td>Reembolso de pago</td>
              <td>Imagen</td>
            </g:if>
          </g:each>
        </table>
      </td>
    </tr>

    </g:if>

  </table>
</g:each>