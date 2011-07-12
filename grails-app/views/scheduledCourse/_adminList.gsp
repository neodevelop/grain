<%@ page import="com.synergyj.grain.course.RegistrationStatus; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.ReceiptStatus" %>
    <ul>
      <g:each in="${scheduledCourseList}" var="scheduledCourse" status="i">
        <li><a href="#sc-${i}">${scheduledCourse.course.courseKey}</a></li>
      </g:each>
    </ul>

    <g:each in="${scheduledCourseList}" var="scheduledCourse" status="i">
    <div id="sc-${i}">
      <h1>Lista de inscritos</h1>
      <h3>Comienza: <g:formatDate date="${scheduledCourse.beginDate}" format="EEEE dd-MM-yy"/> </h3>
      <ul id="registrations">
      <g:each in="${registrationsPerScheduledCourse[scheduledCourse.course.courseKey]}" var="registration" status="j">
        <li id="registration${registration.id}">
          <b>${registration?.student?.firstName ?: ''}
            ${registration?.student?.lastName ?: ''}</b>
          ${registration?.student?.email} -
          ${registration.registrationStatus}
          <g:if test="${registration.registrationStatus == RegistrationStatus.REGISTERED || registration.registrationStatus == RegistrationStatus.PENDING_PAYMENT}">
            - <g:remoteLink controller="registration" action="delete" id="${registration.id}" onSuccess="removeRegistration(${registration.id})">Borrar</g:remoteLink>
          </g:if>

          <g:if test="${registration?.payments?.size()}">
          <ul>
            <g:each in="${registration?.payments}" var="payment" status="k">
            <li>
              $ ${payment.amount}
              - ${payment.paymentStatus}
              - <g:if test="${payment.paymentStatus == PaymentStatus.PENDING || payment.paymentStatus == PaymentStatus.WAITING}">
                <g:link controller="payment" action="edit" id="${payment.id}">
                  Modificar
                </g:link>
                </g:if>
              <g:if test="${payment?.receipts?.size()}">
                <ul>
                  <g:each in="${payment?.receipts}" var="receipt">
                    <li id="receipt${receipt.id}">
                      ${receipt.receiptStatus} -
                      <g:link controller="receipt" action="showImage" id="${receipt.id}" class="seeReceipt">Ver Recibo </g:link>
                      <g:if test="${receipt.receiptStatus == ReceiptStatus.RECEIVED}">
                        -
                        <g:remoteLink update="approveResult${receipt.id}" controller="receipt" action="approve" id="${receipt.id}">
                          <span id="approveResult${receipt.id}">Aprobar</span>
                        </g:remoteLink>
                        <g:remoteLink controller="receipt" action="delete" id="${receipt.id}" onSuccess="removeReceipt(${receipt.id})">
                          &nbsp;-&nbsp; Borrar
                        </g:remoteLink>
                      </g:if>
                    </li>
                  </g:each>
                </ul>
              </g:if>
            </li>
            </g:each>
          </ul>
          </g:if>
        </li>
      </g:each>
      </ul>
    </div>
    </g:each>