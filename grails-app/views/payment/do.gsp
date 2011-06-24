<html>
<head>
  <title><g:message code='payment.do' default="Making payment"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'payment.do', default: 'Making payment')}"/>
  <script type="text/javascript" src="${createLinkTo(dir:'themes/wb/js/payment',file:'do.js')}"></script>
  <g:javascript>
    <g:if test="${!user?.firstName || !user?.lastName }">
      $(function(){
        $('#lightbox').css({width:'100%',height:'100%'}).fadeIn(500,function(){
          $("#userDataForm").fadeIn(300);
        });
        var selector = $("form[name=updateUser] > input[type=text]");
        selector.keypress(function(){
          if ($(this).val().length <= 2) {
            $(this).addClass("error");
            $(this).removeClass("text");
          }else{
            $(this).addClass("text");
            $(this).removeClass("error");
          }
        });
      });

      function ok(){
        $("input[name=buyer_name]").val($("#firstName").val());
        $("input[name=buyer_lastname]").val($("#lastName").val());
        $("#userDataForm").fadeOut(500,function(){
          $('#lightbox').css({width:'0',height:'0'}).fadeIn(500);
        });
        $("form#dineroMail").submit();
        $("#waitMessage").fadeIn('slow');
      }
    </g:if>
    <g:else>
      $(function(){
        $("form#dineroMail").submit();
        $("#waitMessage").fadeIn('slow');
      });
    </g:else>
  </g:javascript>
</head>
<body>
<div id="progress" align="center" style="height:250px;">
  <img src="${createLinkTo(dir:'themes/wb/images',file:'ajax-loader.gif')}" title="progress" alt="loader"/>
  <div id="waitMessage" align="center" style="display:none;">
    Espera un momento por favor...
  </div>
</div>
<div>

  <g:if test="${!user?.firstName || !user?.lastName }">
  <div id="lightbox"></div>
  <div id="userDataForm">
    <div class="title"> Antes de continuar! </div>
      <div class="sub-title">
        Necesitamos un poco m&aacute;s de informaci&oacute;n para comenzar con tu entrenamiento...
      </div>
      <g:formRemote url="[controller:'user',action:'save']" name="updateUser" method="post" onSuccess="ok()" >
        <g:hiddenField name="isAjax" value="true"/>
        <label>Tu(s) nombre(s) aqui:</label><br/>
        <input id="firstName" name="firstName" value="" class="text" tabindex="1" type="text">
        <span id="validName"></span><br/>
        <label>Tu(s) apelllido(s) aqui:</label><br/>
        <input id="lastName" name="lastName" value="" class="text" tabindex="2" type="text">
        <span id="validLastName"></span><br/>
        <div align="center">
        <input value="Continuar" class="continue" tabindex="3" type="submit">
        </div>
      </g:formRemote>
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
    <input type="hidden" name="ok_url" value="${request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath}/me?status=payed&trx=${payment.transactionId}" />
    <input type="hidden" name="error_url" value="${request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath}/me?status=error&trx=${payment.transactionId}" />
    <input type="hidden" name="pending_url" value="${request.scheme+'://'+request.serverName+(request.serverPort == 80 ? '' : ':'+request.serverPort )+request.contextPath}/me?status=pending&trx=${payment.transactionId}" />
    <input type="hidden" name="buyer_message" value="0" />
    <input type="hidden" name="change_quantity" value="0" />
    <input type="hidden" name="display_shipping" value="0" />
    <input type="hidden" name="display_additional_charge" value="0" />
    <!-- Variables de Medios de Pago-->
    <input type="hidden" name="payment_method_available" value="mx_scotiabank_tc,1,3;mx_santander_tc,1,3;mx_oxxo;mx_otherbank_tc,1,3;mx_ixe_tc,1,3;mx_bancomer_tc,1,3;mx_amex,1,3;mx_7eleven" />
    <input type="hidden" name="payment_method_1" value="" />
    <!-- Variables del Producto/Item -->
    <!-- Item 1 -->
    <input type="hidden" name="item_name_1" value="${registration.scheduledCourse.course}" />
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
    <input type="hidden" name="expanded_step_PM" value="0" />
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

</div>
</body>
</html>