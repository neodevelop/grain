<head>
  <meta name="layout" content="wb"/>
  <parameter name="pageHeader" value="${g.message(code: 'user.signup', default: 'Signup')}"/>
</head>
<body>
<g:render template="/common/errors" model="[instance:userdata]"/>

<jqvalui:renderValidationScript for="com.synergyj.grain.auth.RegisterUserCommand" form="registerForm" errorClass="invalid" validClass="success" onsubmit="true"/>

<g:form name="registerForm" action="user" method="post" controller="register">

  <div class="form-wrapper" id="signup">
    <div id="sign-up">
      <h1><g:message code="user.create" default="Create a new user"/></h1>
      <p class="alt-login">%{--Or log in directly with your <a href="/login">OpenID--}%</a></p>
      <p><g:message code="register.alt" default="Creating a user account allows you to enroll yourself in training events."/></p>
      <ul>
        <li>
          <label for="email"><g:message code='login.username'/></label>
          <input type="text" id="email" name="email" value="${fieldValue(bean: userdata, field: 'email')}"/>
        </li>
        <li>
          <label for="password"><g:message code='login.password'/></label><br/>
          <input type="password" maxlength="200" id="password" name="password" value="${fieldValue(bean: userdata, field: 'password')}"/>
        </li>
        <li>

        </li>
        <li>
          <div class="tos">
            <g:checkBox name="tos" id="tos" checked="${fieldValue(bean: userdata, field: 'tos')}" />
            <label for="tos">I accept the
            <a href="${g.createLink(mapping: 'tos')}" target="_blank"><g:message code='tos' default="Terms of Service"/></a>
          </label>
          </div>
          <div class="submit">
            <input class="sendButton" name="sendButton" type="submit" value="${g.message(code: 'login.register')}"/>
          </div>

        </li>
      </ul>

    </div>

  </div>
</g:form>
</body>