  <div class="instrucciones">
    A través de este medio serás redirigido a un procesdor de pagos,
    en donde podrás generar tu recibo de pago que podrás presentar en la tienda de tu elección.
  </div>
  <div class="medios">
    <r:img uri="/images/7-eleven-icon.png" title="7eleven" alt="7eleven"/>
    <r:img uri="/images/oxxo-icon.gif" title="oxxo" alt="oxxo"/>
  </div>
  <div class="action">
    <g:link class="btn btn-success submit" action="${pay ?: 'create'}" name="dineromail"  >
      <i class="icon-print icon-white"></i>
      Imprimir recibo de pago
    </g:link>
  </div>