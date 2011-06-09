<html>
  <head>
    <meta name="layout" content="wb" />
    <title><g:message code="registration.confirm" default="Confirm registration" /></title>
    <parameter name="pageHeader" value="${g.message(code: 'registration.confirm', default: 'Confirm Registration')}"/>
  </head>
  <body>
  <div id="left">
    <div id="leftbox">
      <sec:ifNotLoggedIn>
        <g:render template="/login/form"/>
      </sec:ifNotLoggedIn>
      <sec:ifLoggedIn>
        <g:render template="/login/logged"/>
      </sec:ifLoggedIn>
    </div>
  </div>
  <div id="right">
    <div id="rightbox">
      <h1>Información del curso</h1>
    </div>
  </div>
  </body>
</html>