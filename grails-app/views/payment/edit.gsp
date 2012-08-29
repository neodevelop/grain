<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.edit' default="Edit payment info"/></title>
  <meta name='layout' content="mainContent"/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.edit', default: 'Edit payment info')}"/>
</head>
<body>
<div class="content">
  <g:render template="/common/errors" model="[instance:payment]"/>
  <g:form controller="payment">
    <g:render template="form" bean="payment"/>
    <div class="buttons">
      <span class="button">
        <g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" />
      </span>
      <span class="button">
        <g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
      </span>
    </div>
  </g:form>
</div>
</body>
