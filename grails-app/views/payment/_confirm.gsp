<div id="payments">
  <g:each in="${payments}" var="payment" status="i">
    Payment ${i + 1}: $ ${payment.amount}<br/><br/>
  </g:each>
</div>
<input type="hidden" name="TipoMoneda" value="1">
<a href="https://mexico.dineromail.com/Shop/Shop_Ingreso.asp?NombreItem=Curso%3A+Desarrollo+profesional+con+Spring+3&TipoMoneda=1&PrecioItem=7000%2E00&E_Comercio=580433&NroItem=-&image_url=http%3A%2F%2Fsynergyj%2Ecom%2Fimages%2Flogo%2Egif&DireccionExito=http%3A%2F%2Fentrenamiento%2Esynergyj%2Ecom%2Fok&DireccionFracaso=http%3A%2F%2Fentrenamiento%2Esynergyj%2Ecom%2Ferror&DireccionEnvio=0&Mensaje=0">
  <img src="https://mexico.dineromail.com/imagenes/botones/pagar-medios_c.gif" border="0" />
</a>