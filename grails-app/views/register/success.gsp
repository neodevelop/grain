<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <parameter name="pageHeader" value="${g.message(code: 'user.create.success', default: 'Signup Success')}"/>
  <script language="javascript">
  function leave() {
    window.location = "${request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath+'/login'}";
  }
  setTimeout("leave()", 5000);
  </script>
</head>
<body>
  <g:if test="${user.id}">
      <div align="center">
        <h2>Haz quedado registrado</h2>
        <h3>Te hemos enviado un correo a <b>${user.email}</b></h3>
        <h4>En 5 segundos podrás empezar a hacer uso de esta cuenta...</h4>
    </div>
  </g:if>
</body>
