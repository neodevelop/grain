    <div class="instrucciones">
      En el portal de tu banco realiza tu pago por la cantidad
      que escogiste, a la siguiente cuenta.
    </div>
    <content:body key="spei" language="es"/>

    <div id="confirmAmountSpei" class="confirmAmount">
      Cantidad a pagar: <span class="data">$ <span id="paymentAmountSpei"></span></span>
    </div>

    <div class="instrucciones">
      Una vez realizado, haz una <b>captura de la pantalla</b> con el pago realizado
      o <b>imprime</b> el comprobante expedido por el banco y <b>escanealo</b>.<br/>
      Te pediremos que dicho comprobante <b>(en imagen JPEG)</b> lo anexes después como recibo de pago.
      Esta operación la podrás hacer en tu perfil.
    </div>
    <div id="finish">
      <g:link class="submit" action="${pay ?: 'create'}" >Haré mi pago en el portal de mi banco...</g:link>
    </div>
    <div id="sendMeInfo">
      Recibirás esta información por correo...
    </div>
