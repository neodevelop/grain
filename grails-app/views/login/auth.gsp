<head>
  <title><g:message code='login.title'/></title>
  <meta name='layout' content='main'/>
  <r:require module="common"/>
  <script language="javascript">
    $(function(){
      $("input[name=j_username]").focus();
    });
  </script>
</head>
<body>
<div class="row">
  <div class="span5">
    <div class="page-header">
      <h1>Bienvenido <small>Ingresa con los datos de tu cuenta</small></h1>
    </div>
    <div class="row">
      <g:render template="/login/form" model="[postUrl:postUrl,rememberMeParameter:rememberMeParameter]"/>
    </div>
  </div>
</div>
</body>
