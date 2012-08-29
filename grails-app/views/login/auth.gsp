<head>
  <title><g:message code='login.title'/></title>
  <meta name='layout' content='main'/>
  
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
      <g:if test="${flash.messageOk}">
        <div class="alert alert-info">
          <button data-dismiss="alert" class="close" type="button">×</button>
          <strong>¡Oye!</strong> ${flash.messageOk}
        </div>
      </g:if>
      <g:render template="/login/form" model="[postUrl:postUrl,rememberMeParameter:rememberMeParameter]"/>
    </div>
  </div>
</div>
</body>
