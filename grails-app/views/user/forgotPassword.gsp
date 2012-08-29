<%@ page contentType="text/html;charset=UTF-8" %>
<head>
  <title><g:message code='me.forgotPassword' default="Forgot my password"/></title>
  <meta name='layout' content='main'/>
  
  <r:script>
    $(function(){
      $("#oldPassword").focus();
      $("#resetPassword").validate({
        errorPlacement: function(error, element) {
          $(element).parent().parent().removeClass('success');
          $(element).parent().parent().addClass('error');
          element.next().remove()
          error.insertAfter(element);
        },
        rules:{
          email: {
            required: true,
            email: true
          }
        },
        messages:{
          email: {
            required: "Escribe tu dirección de correo",
            email:"Esta dirección de correo no es válida"
          }
        },
        success: function(element) {
          $(element).parent().parent().addClass('success');
          element.addClass("valid").text("Ok!")
        },
        validClass: "success",
        errorElement: "span class='help-inline'"
      });
    });
  </r:script>
</head>
<body>
<div class="page-header">
  <h1><g:message code="login.forgotPassword"/>
    <small>Una notificación será enviada a tu correo</small>
  </h1>
</div>
<g:if test="${flash.message}">
  <div class="alert alert-info">
    <button data-dismiss="alert" class="close" type="button">×</button>
    <strong>¡Oye!</strong> ${flash.message}
  </div>
</g:if>
<g:form name="resetPassword" action="sendResetInstructions" method="post" controller="user" class="well form-horizontal">
  <fieldset>
    <div class="control-group">
      <label for="email" class="control-label"><g:message code='login.username'/></label>
      <div class="controls">
        <input type="text" id="email" name="email" value="" class="input-xlarge focused" placeholder="tucorreo@dominio.com"/>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label">&nbsp;</label>
      <div class="controls">
        <input class="btn btn-primary btn-large" name="sendButton" type="submit" value="${g.message(code: 'login.recoverPassword')}"/>
      </div>
    </div>
  </fieldset>
</g:form>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.js"></script>
</body>
