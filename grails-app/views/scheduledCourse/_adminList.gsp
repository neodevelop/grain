<%@ page import="com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.RegistrationStatus; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.ReceiptStatus" %>
  <ul class="nav nav-tabs">
    <g:each in="${scheduledCourseList}" var="scheduledCourse" status="i">
      <li>
        <a href="#sc-${i}" data-toggle="tab">
          ${scheduledCourse.course.courseKey}
        </a>
      </li>
    </g:each>
  </ul>
  <div id="myTabContent" class="tab-content">
    <g:each in="${scheduledCourseList}" var="scheduledCourse" status="i">
    <div id="sc-${i}" class="tab-pane fade">
      <h2>Comienza: <g:formatDate date="${scheduledCourse.beginDate}" format="EEEE dd-MM-yy"/> </h2>
      <g:each in="${RegistrationStatus.values()}" var="registrationStatus">
      <table id="registrations_${registrationStatus}" width="100%" class="registrationsDetail">
        <thead>
          <tr>
            <th>
              ${g.message(code:registrationStatus.code)}
            </th>
          </tr>
        </thead>
        <tbody>
        <g:set var="identifierForScheduledCourse" value="${scheduledCourse.course.courseKey}${scheduledCourse.id}"/>
        <g:findAll in="${registrationsPerScheduledCourse[identifierForScheduledCourse]}" expr="it.registrationStatus == registrationStatus">
          <tr class="registrationRow" id="registration${it?.id}">
            <td>
              ${it?.student?.email}
              <g:if test="${it?.student?.firstName && it?.student?.lastName}">
                <br/>( ${it?.student?.firstName ?: ''} ${it?.student?.lastName ?: ''} )
              </g:if>
            </td>
            <td>
              <g:if test="${it.registrationStatus == RegistrationStatus.REGISTERED || it.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH}">
                <g:remoteLink controller="registration" action="delete" id="${it.id}" onSuccess="removeRegistration(${it.id})">
                  <img src="${resource(dir:'themes/wb/icon',file:'cancel.png')}" width="24" height="24" />
                </g:remoteLink>
                <g:set var="registrationId" value="${it.id}"/>
                <g:remoteLink controller="registration" action="cancel" id="${it.id}" update="cancelRegistration${it.id}">
                  <span id="cancelRegistration${registrationId}">
                  <img src="${resource(dir:'themes/wb/icon',file:'graphite.png')}" width="24" height="24" />
                  </span>
                </g:remoteLink>
                  <img src="${resource(dir:'themes/wb/icon',file:'edit-icon.png')}" width="24" height="24" />
              </g:if>
              <g:else>
                &nbsp;
              </g:else>
            </td>

            <g:if test="${it.registrationStatus == RegistrationStatus.REGISTERED}">
            <td>
              <span id="generatePayment${it.id}">
                <g:set var="registrationId" value="${it.id}"/>
                <g:formRemote name="addPaymentToRegistration" url="[controller:'payment',action:'createForRegistration']" update="generatePayment${registrationId}">
                  <g:hiddenField name="registrationId" value="${registrationId}"/>
                  <g:hiddenField name="costByCourse" value="${scheduledCourse.costByCourse}"/>
                  <g:message code="payment.needInvoice"/>
                  <g:checkBox name="invoice" />
                  # <g:message code="payment.payment"/>s
                  <g:select from="${1..2}" name="percentOption" />
                  <g:select from="${KindOfPayment.values()}" name="paymentOption"/>
                  <g:submitButton name="submit" value="Create"/>
                </g:formRemote>
              </span>
            </td>
            </g:if>

            <g:if test="${it?.payments?.size()}">
            <td>
              <table>
                <g:each in="${it?.payments}" var="payment" status="k">
                  <tr>
                    <td>$ ${payment.amount}</td>
                    <td>${payment.paymentStatus}</td>
                    <td>${payment.kindOfPayment}</td>
                    <td>
                      <g:if test="${payment.paymentStatus == PaymentStatus.PENDING || payment.paymentStatus == PaymentStatus.WAITING || payment.paymentStatus == PaymentStatus.PAYED}">
                        <g:link controller="payment" action="edit" id="${payment.id}">
                        <img src="${resource(dir:'themes/wb/icon',file:'edit-icon.png')}" width="24" height="24" />
                        </g:link>
                      </g:if>
                      <g:else>
                        &nbsp;
                      </g:else>
                    </td>
                    <td>
                      <g:if test="${ payment.paymentStatus == PaymentStatus.PENDING  && payment.kindOfPayment == KindOfPayment.DINERO_MAIL }">
                        <g:remoteLink update="approvePayment${payment.id}" controller="receipt" action="approveDineroMail" id="${payment.id}" params="[registrationId:it.id]">
                          <span id="approvePayment${payment.id}">
                            <img src="${resource(dir:'themes/wb/icon',file:'valid-blue.png')}" width="24" height="24" />
                          </span>
                        </g:remoteLink>
                      </g:if>
                      <g:if test="${payment?.receipts?.size()}">
                        <table>
                          <tbody>
                            <g:each in="${payment?.receipts}" var="receipt">
                            <tr id="receipt${receipt.id}">
                              <td>${receipt.receiptStatus}</td>
                              <td>
                                <a href="${receipt.url()}" class="seeReceipt">
                                  <img src="${resource(dir:'themes/wb/icon',file:'search.png')}" width="24" height="24" />
                                </a>
                              </td>
                              <g:if test="${receipt.receiptStatus == ReceiptStatus.RECEIVED}">
                                <td>
                                  <g:remoteLink update="approveResult${receipt.id}" controller="receipt" action="approve" id="${receipt.id}">
                                    <span id="approveResult${receipt.id}">
                                      <img src="${resource(dir:'themes/wb/icon',file:'valid-blue.png')}" width="24" height="24" />
                                    </span>
                                  </g:remoteLink>
                                </td>
                                <td>
                                  <g:remoteLink controller="receipt" action="delete" id="${receipt.id}" onSuccess="removeReceipt(${receipt.id})">
                                    <img src="${resource(dir:'themes/wb/icon',file:'remove-red.png')}" width="24" height="24" />
                                  </g:remoteLink>
                                </td>
                              </g:if>
                              </td>
                            </tr>
                            </g:each>
                          </tbody>
                        </table>
                      </g:if>
                      <g:else>
                        <g:if test="${payment?.kindOfPayment == KindOfPayment.SPEI}">
                          <g:link controller="payment" action="uploadReceipt" name="uploadReceipt${payment.id}">
                            <img src="${resource(dir:'themes/wb/icon',file:'upload.png')}" width="24" height="24" />
                          </g:link>
                        </g:if>
                      </g:else>
                    </td>
                  </tr>
                </g:each>
              </table>
            </td>
            </g:if>
            <td>
              <g:if test="${it.invoice}">
                <img src="${resource(dir:'themes/wb/icon',file:'invoice.png')}" width="24" height="24" />
              </g:if>
              <g:else>
                &nbsp;
              </g:else>
            </td>
            <td>
              <table>
              <g:each in="${it.promotions}" var="promotionPerRegistration">
                <tr>
                  <td>${promotionPerRegistration.promotion}</td>
                </tr>
              </g:each>
              </table>
            </td>
          </tr>
        </g:findAll>
        </tbody>
      </table>
      </g:each>
    </div>
    </g:each>
  </div>