<div id="profile" style="display:<sec:ifLoggedIn>block</sec:ifLoggedIn><sec:ifNotLoggedIn>none</sec:ifNotLoggedIn>;">
  <div id="uservatar">
    <sec:ifLoggedIn>
    <avatar:gravatar email="${sec.loggedInUserInfo(field:'username')}" size="50" />
    </sec:ifLoggedIn>
  </div>
  <h1><g:message code='login.welcome' default="Welcome!"/></h1>
  <div id="loggedas">
    <g:message code='login.loggedas' default="You're logged as:"/>
  </div>
  <div id="useremail">
    <sec:loggedInUserInfo field="username"/>
  </div>
  <div id="notyou">
    <a href="#" id="notme">
      <g:message code='login.notyou' default="aren't you? this is not me!"/>
    </a>
  </div>
</div>