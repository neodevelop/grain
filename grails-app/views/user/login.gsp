<head>
  <title><g:message code='login.title'/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'login.title', default: 'Login')}"/>
</head>
<body>
<div class="login-inner">
  <form action='${postUrl}' method='POST' id="loginForm" name="loginForm" autocomplete='off'>
    <div class="sign-in">
      <h1><g:message code='login.signin'/></h1>
      <table>
        <tr>
          <td><label for="username"><g:message code='login.username'/></label></td>
          <td><input name="j_username" type="text" id="username" size="20"/></td>
        </tr>
        <tr>
          <td><label for="password"><g:message code='login.password'/></label></td>
          <td><input type="password" name="j_password" id="password" size="20"/></td>
        </tr>
        <tr>
          <td colspan='2'>
            <input type="checkbox" class="checkbox" name="${rememberMeParameter}" id="remember_me" checked="checked"/>
            <label for='remember_me'><g:message code='login.rememberme'/></label> |
            <span class="forgot-link">
              <g:link mapping='forgotPassword'><g:message code='login.forgotPassword'/></g:link>
            </span>
          </td>
        </tr>
        <tr>
          <td colspan='2'>
            <g:link mapping='signup'><g:message code='login.register'/></g:link>
            <g:submitButton name="loginSubmit" value="${g.message(code:'login.login')}"/>
          </td>
        </tr>
      </table>
    </div>
  </form>
</div>
</body>