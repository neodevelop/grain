<head>
  <meta name="layout" content="wb"/>
  <parameter name="pageHeader" value="${g.message(code: 'user.create', default: 'Signup')}"/>
</head>
<body>
<g:render template="/common/errors" model="[instance:userdata]"/>

<jqvalui:renderValidationScript for="com.synergyj.grain.auth.RegisterUserCommand" form="registerForm" errorClass="invalid" validClass="success" onsubmit="true"/>

<g:form name="registerForm" action="user" method="post" controller="register">
  <table>
    <tbody>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="email"><g:message code='login.username'/></label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: userdata, field: 'email', 'errors')}">
        <input type="text" id="email" name="email" value="${fieldValue(bean: userdata, field: 'email')}"/>
      </td>
    </tr>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="password"><g:message code='login.password'/></label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: userdata, field: 'password', 'errors')}">
        <input type="password" maxlength="200" id="password" name="password" value="${fieldValue(bean: userdata, field: 'password')}"/>
      </td>
    </tr>
    </tbody>
  </table>
  <input class="sendButton" name="sendButton" type="submit" value="${g.message(code: 'login.register')}"/>
</g:form>
</body>