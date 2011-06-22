<html>
<head>
  <title><g:message code='payment.do' default="Making payment"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.do', default: 'Making payment')}"/>
</head>
<body>
  <h1>Place your content</h1>
  <div>
  <form action="https://mexico.dineromail.com/Shop/Shop_Ingreso.asp" method="post">
  <input type="hidden" name="NombreItem" value="${registration?.scheduledCourse?.course?.name}">
  <input type="hidden" name="TipoMoneda" value="1"> <input type="hidden" name="PrecioItem" value="${payment?.amount}">
  <input type="hidden" name="E_Comercio" value="580433">
  <input type="hidden" name="NroItem" value="${registration?.scheduledCourse?.course?.courseKey}">
  <input type="hidden" name="DireccionExito" value="http://localhost:8080/me">
  <input type="hidden" name="DireccionFracaso" value="http://localhost:8080/me?error=1">
  <input type="hidden" name="DireccionEnvio" value="0">
  <input type="hidden" name="Mensaje" value="0">
  <input type='hidden' name='MediosPago' value='4,5,19,20,13,14,2'>
  <input type="image" src="https://mexico.dineromail.com/imagenes/botones/pagar-tarjetas_bn.gif" border="0" name="submit" alt="Pagar con DineroMail">
  </form>
  </div>
</body>
</html>