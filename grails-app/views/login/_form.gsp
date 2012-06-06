<div id="loginForm" style="display:<sec:ifLoggedIn>none</sec:ifLoggedIn><sec:ifNotLoggedIn>block</sec:ifNotLoggedIn>;">
  <form action='${postUrl}' method='POST' id="auth" name="auth" autocomplete='off' class="form-horizontal">
      <div id="loginMessage" class="alert alert-error" style="padding: 0px; display: none; text-align: center;">
        <p>
          <span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
          <span id="jsonMessage"></span>
        </p>
      </div>

      <div class="control-group">
        <label for="username" class="control-label">
          <g:message code='login.username'/>:
        </label>
        <input name="j_username" type="text" id="username" size="30" value="${email}" class="focused"/>
      </div>

      <div class="control-group">
        <label for="password" class="control-label">
          <g:message code='login.password'/>:
        </label>
        <input type="password" name="j_password" id="password" size="30" class="focused"/>
      </div>

      <table id="login">
        <tr class="links">
          <td colspan='2' align="center">
            <input type="checkbox" class="checkbox" name="${rememberMeParameter}" id="remember_me" checked="checked"/>
            <label for='remember_me' class="remember_me_label"><g:message code='login.rememberme'/></label> |
            <span class="forgot-link">
              <g:link mapping='forgotPassword'><g:message code='login.forgotPassword'/></g:link>
            </span> |
            <g:if test="${scheduledCourseId}">
              <g:link mapping='signup' params="[scheduledCourseId:scheduledCourseId]">
                <g:message code='login.register'/>
              </g:link>
            </g:if>
            <g:else>
              <g:link mapping='signup'><g:message code='login.register'/></g:link>
            </g:else>

          </td>
        </tr>
        <tr>
          <td colspan='2' align="center">
            <g:submitButton name="loginSubmit" value="${g.message(code:'login.login')}" class="btn btn-primary"/>
          </td>
        </tr>
      </table>
  </form>
</div>