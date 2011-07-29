  <table id="${tableName}" border="1px">
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
      <g:each in="${registrationGroup}" var="registration">
      <tr id="student${registration?.student?.id}">
        <td>${registration?.student?.email}</td>
        <td>${registration?.student?.firstName} ${registration?.student?.lastName}</td>
        <td>
          <g:remoteLink controller="studentsGroup" action="${action}" id="${registration?.student?.id}" params="[studentsGroupId:studentsGroup?.id]" onSuccess="${action}(${registration?.student?.id})">
            <g:message code="studentsGroup.move" />
          </g:remoteLink>
        </td>
        <td>${registration?.registrationStatus}</td>
        <td>
          <g:formatBoolean boolean="${registration?.invoice}" true="Yes" false="No"/>
        </td>
        <td>
          <table id="promotionsForRegistration${registration?.id}" border="1">
            <tr>
              <g:each in="${registration?.promotions}" var="promotionPerRegistration">
                <td>${promotionPerRegistration?.promotion}</td>
              </g:each>
            </tr>
          </table>
        </td>
        <td>
          <table id="paymentsForRegistration${registration?.id}" border="1">
            <tr>
              <g:each in="${registration?.payments}" var="payment">
                <td>${payment?.amount} - ${payment?.paymentStatus}</td>
              </g:each>
            </tr>
          </table>
        </td>
      </tr>
      </g:each>
    </tbody>
  </table>