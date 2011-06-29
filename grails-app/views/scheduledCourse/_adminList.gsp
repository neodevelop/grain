<%@ page import="com.synergyj.grain.course.ReceiptStatus" %>
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
      <g:each in="${registrationsPerScheduledCourse[scheduledCourse.course.courseKey]}" var="registration">
        <li>
          <b>${registration?.student?.firstName ?: ''}
            ${registration?.student?.lastName ?: ''}</b>
          ${registration?.student?.email} -
          ${registration.registrationStatus}
          <g:if test="${registration?.payments?.size()}">
          <ul>
            <g:each in="${registration?.payments}" var="payment">
            <li>
              $ ${payment.amount}
              - ${payment.paymentStatus}
              <g:if test="${payment?.receipts?.size()}">
                <ul>
                  <g:each in="${payment?.receipts}" var="receipt">
                    <li>
                      ${receipt.receiptStatus} -
                      <g:link controller="receipt" action="showImage" id="${receipt.id}" class="seeReceipt">Ver Recibo </g:link>
                      <g:if test="${receipt.receiptStatus == ReceiptStatus.RECEIVED}">
                        -
                        <g:remoteLink update="approveResult${receipt.id}" controller="receipt" action="approve" id="${receipt.id}">
                          <span id="approveResult${receipt.id}">Aprobar</span>
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