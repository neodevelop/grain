<html>
<head>
  <title><g:message code='payment.do' default="Making payment"/></title>
  <meta name='layout' content='main'/>
  
  <r:script>
    <g:if test="${!user?.firstName || !user?.lastName }">
      $(function(){
        $("#extraInfoForm").modal({show:true,backdrop:"static"});
        var selector = $("form[name=updateUser] input[type=text]");
        selector.keypress(function(){
          if ($(this).val().length <= 2) {
            $(this).parent().addClass("error");
          }else{
            $(this).parent().removeClass("error");
          }
        });
        $("#saveAndContinue").click(function(){ $("#updateUser").submit(); });
      });

      function ok(){
        $("input[name=buyer_name]").val($("#firstName").val());
        $("input[name=buyer_lastname]").val($("#lastName").val());
        $("#extraInfoForm").modal("hide");
        $("form#dineroMail").submit();
      }
    </g:if>
    <g:else>
      $(function(){
        $("form#dineroMail").submit();
      });
    </g:else>
  </r:script>
</head>
<body>
  <div class="page-header">
    <h1>Iniciando el proceso de pago
      <small>Redireccionando a DineroMail</small>
    </h1>
  </div>

  <div class="progress progress-striped active" id="loaderProgressBar">
    <div style="width: 100%" class="bar"></div>
  </div>

  <g:if test="${!user?.firstName || !user?.lastName }">
    <div class="modal hide" id="extraInfoForm">
      <div class="modal-header">
        <h3>Necesitamos saber un poco más de ti</h3>
      </div>
      <div class="modal-body">
        <p>Estos datos también nos servirán para la correcta acreditación y expedición de tu diploma.</p>
        <g:formRemote url="[controller:'user',action:'save']" name="updateUser" method="post" onSuccess="ok()" class="form-horizontal">
          <fieldset>
            <g:hiddenField name="isAjax" value="true"/>
            <div class="control-group">
              <label class="control-label">Tu(s) nombre(s) aqui: &nbsp;</label>
              <input id="firstName" name="firstName" value="" tabindex="1" type="text"/>
              <span id="validName"></span>
            </div>
            <div class="control-group">
              <label class="control-label">Tu(s) apelllido(s) aqui: &nbsp;</label>
              <input id="lastName" name="lastName" value="" tabindex="2" type="text"/>
              <span id="validLastName"></span>
            </div>
          </fieldset>
        </g:formRemote>
      </div>
      <div class="modal-footer">
        <a href="#" id="saveAndContinue" class="btn btn-primary">Guardar y continuar</a>
      </div>
    </div>
  </g:if>

  <form id="dineroMail" action="https://checkout.dineromail.com/CheckOut" method="post" >
    <!-- Variables del Vendedor -->
    <input type="hidden" name="tool" value="button" />
    <input type="hidden" name="merchant" value="0580433" />
    <input type="hidden" name="country_id" value="4" />
    <input type="hidden" name="seller_name" value="cursos@synergyj.com" />
    <input type="hidden" name="language" value="es" />
    <input type="hidden" name="transaction_id" value="${payment.transactionId}" />
    <input type="hidden" name="currency" value="mxn" />
    <input type="hidden" name="ok_url" value="${request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath}/receivePayment?status=payed&trx=${payment.transactionId}" />
    <input type="hidden" name="error_url" value="${request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath}/receivePayment?status=error&trx=${payment.transactionId}" />
    <input type="hidden" name="pending_url" value="${request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath}/receivePayment?status=pending&trx=${payment.transactionId}" />
    <input type="hidden" name="buyer_message" value="0" />
    <input type="hidden" name="change_quantity" value="0" />
    <input type="hidden" name="display_shipping" value="0" />
    <input type="hidden" name="display_additional_charge" value="0" />
    <!-- Variables de Medios de Pago-->
    <input type="hidden" name="payment_method_available" value="mx_scotiabank_tc,1,3;mx_santander_tc,1,3;mx_oxxo;mx_otherbank_tc,1,3;mx_ixe_tc,1,3;mx_bancomer_tc,1,3;mx_amex,1,3;mx_7eleven" />
    <input type="hidden" name="payment_method_1" value="" />
    <!-- Variables del Producto/Item -->
    <!-- Item 1 -->
    <input type="hidden" name="item_name_1" value="${registration.scheduledCourse.course.name}" />
    <input type="hidden" name="item_code_1" value="${registration.scheduledCourse.course.courseKey}" />
    <input type="hidden" name="item_quantity_1" value="1" />
    <input type="hidden" name="item_ammount_1" value="${payment.amount.setScale(2, BigDecimal.ROUND_HALF_EVEN).toString()}" />
    <input type="hidden" name="item_currency_1" value="mxn" />

    <!-- Variables del Comprador -->
    <input type="hidden" name="buyer_name" value="${user?.firstName}" />
    <input type="hidden" name="buyer_lastname" value="${user?.lastName}" />
    <input type="hidden" name="buyer_email" value="<sec:username/>" />

    <!-- Variables de Diseño-->
    <input type="hidden" name="header_image" value="http://synergyj.com/images/logo.gif" />
    <input type="hidden" name="header_width" value="1" />
    <input type="hidden" name="expanded_step_PM" value="1" />
    <input type="hidden" name="expanded_step_AD" value="0" />
    <input type="hidden" name="expanded_step_SC" value="0" />
    <input type="hidden" name="expanded_sale_detail" value="1" />
    <input type="hidden" name="step_color" value="F6F6F6" />
    <input type="hidden" name="hover_step_color" value="E8FFD3" />
    <input type="hidden" name="links_color" value="669900" />
    <input type="hidden" name="font_color" value="666666" />
    <input type="hidden" name="border_color" value="999999" />
    <input type="hidden" name="button_color" value="7DBE0B" />
  </form>

</body>
</html>