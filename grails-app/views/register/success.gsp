<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <parameter name="pageHeader" value="${g.message(code: 'user.create.success', default: 'Signup Success')}"/>
</head>
<body>
  <g:if test="${user.id}">
      <div align="center">
        <h2>Haz quedado registrado</h2>
      </div>
      <h3>Te hemos enviado un correo a <b>${user.email}</b> para que puedas activar tu cuenta...</h3>
  </g:if>
</body>
