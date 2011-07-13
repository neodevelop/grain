<head>
  <title><g:message code='login.title'/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'login.title', default: 'Login')}"/>
</head>
<body>
<div id="log-in">
  <g:render template="/login/form" model="[postUrl:postUrl,rememberMeParameter:rememberMeParameter]"/>
</div>
</body>
