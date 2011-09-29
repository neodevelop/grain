<div class="instrucciones">
  Te facilitamos una forma de pago
</div>

A través de este medio podrás pagar con cualquiera de las siguientes opciones:

<div id="medios">
  <img src="${resource(dir:'themes/wb/icon',file:'visa-icon.gif')}" title="visa" alt="visa"/>
  <img src="${resource(dir:'themes/wb/icon',file:'mastercard-icon.gif')}" title="mastercard" alt="mastercard"/>
  <img src="${resource(dir:'themes/wb/icon',file:'amex-icon.png')}" title="amex" alt="amex"/>
  <img src="${resource(dir:'themes/wb/icon',file:'7-eleven-icon.png')}" title="7eleven" alt="7eleven"/>
  <img src="${resource(dir:'themes/wb/icon',file:'oxxo-icon.gif')}" title="oxxo" alt="oxxo"/>
</div>

<div id="confirmAmountDM" class="confirmAmount">
  Cantidad a pagar: <span class="data">$ <span id="paymentAmountDM"></span></span>
</div>

<div id="finish">
  <g:link class="submit" action="${pay ?: 'create'}">Realizar mi pago en línea</g:link>
</div>
<div id="sendMeInfo">
  Serás direccionado a un sitio seguro donde podrás realizar esta operación...<br/>
  Una vez realizado el pago, estarás de vuelta con nosotros.<br/>
</div>