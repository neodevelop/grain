<%@ page import="com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.PaymentService; com.synergyj.grain.course.RegistrationStatus" %>
  <table id="${tableName}" class="table table-condensed">
    <thead>
      <tr>
        <th><g:message code="login.username"/></th>
        <th><g:message code="me.name"/></th>
        <th><g:message code="studentsGroup.move"/></th>
        <th><g:message code="registration.status" default="Status"/></th>
      </tr>
    </thead>
    <tbody>
      <g:each in="${registrationGroup}" var="registration">
      <tr id="student${registration?.id}" class="registration_${registration?.registrationStatus}">
        <td>${registration?.student?.email}</td>
        <td>${registration?.student?.firstName} ${registration?.student?.lastName}</td>
        <td align="center">
          <g:remoteLink controller="studentsGroup" action="${action}" id="${registration?.id}" onSuccess="${action}(${registration?.id})">
            <g:message code="studentsGroup.move" />
          </g:remoteLink>
        </td>
        <td>
          ${registration.registrationStatus}
        </td>
      </tr>
      </g:each>
    </tbody>
  </table>