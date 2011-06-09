  <div id="uservatar">
    <avatar:gravatar email="${sec.loggedInUserInfo(field:'username')}" size="50" />
  </div>
  <h1><g:message code='login.welcome' default="Welcome!"/></h1>
  <div id="loggedas">
    You're logged as:
  </div>
  <div id="username">
    <sec:loggedInUserInfo field="username"/><br/>
  </div>
  <div id="notyou">
    <g:link>
    aren't you? this is not me!
    </g:link>
  </div>

