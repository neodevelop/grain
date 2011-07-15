<head>
  <title><g:message code='login.title'/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'login.title', default: 'Login')}"/>
  <script language="javascript">
    $(function(){
      $("input[name=j_username]").focus();
    });
  </script>
</head>
<body>
<div id="login">
  <g:render template="/login/form" model="[postUrl:postUrl,rememberMeParameter:rememberMeParameter]"/>
</div>
</body>
