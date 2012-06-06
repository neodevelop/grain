<sec:ifLoggedIn>
<div id="profile">
  <div id="uservatar">
    <avatar:gravatar email="${sec.loggedInUserInfo(field:'username')}" size="50" />
  </div>
  <div id="loggedas">
    <h4><g:message code='login.loggedas' default="You're logged as:"/></h4>
  </div>
  <div id="useremail">
    <h3><sec:loggedInUserInfo field="username"/></h3>
  </div>
</div>
</sec:ifLoggedIn>