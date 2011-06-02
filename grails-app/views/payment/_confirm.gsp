<div id="payments">
  <g:each in="${payments}" var="payment" status="i">
    Payment ${i + 1}: $ ${payment.amount}<br/><br/>
  </g:each>
</div>

<form action="https://mexico.dineromail.com/Shop/Shop_Ingreso.asp" method="post">
  <input type="hidden" name="NombreItem" value="Curso: Desarrollo profesional con Spring 3">
  <input type="hidden" name="TipoMoneda" value="1">
  <input type="hidden" name="PrecioItem" value="7000.00">
  <input type="hidden" name="E_Comercio" value="580433">
  <input type="hidden" name="NroItem" value="SPRING.2011">
  <input type="hidden" name="image_url" value="http://synergyj.com/images/logo.gif">
  <input type="hidden" name="DireccionExito" value="http://localhost:8080/ok">
  <input type="hidden" name="DireccionFracaso" value="http://localhost:8080/error">
  <input type="hidden" name="DireccionEnvio" value="0">
  <input type="hidden" name="Mensaje" value="0">
  <input type='hidden' name='MediosPago' value='4,5,19,20,13,14,18,2,7'>
  <input type="image" src="https://mexico.dineromail.com/imagenes/botones/pagar-medios_c.gif" border="0" name="submit" alt="Pagar con DineroMail">
</form>