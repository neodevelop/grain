<%@ page contentType="text/html;charset=UTF-8" %>

<head>
  <title><g:message code='me.changePassword' default="Change my password"/></title>
  <sec:ifLoggedIn>
  <meta name='layout' content="mainContent"/>
  </sec:ifLoggedIn>
  <sec:ifNotLoggedIn>
  <meta name='layout' content='main'/>
  </sec:ifNotLoggedIn>
  
  <r:script>
    $(function(){
      $("#oldPassword").focus();
      $("#updatePassword").validate({
        errorPlacement: function(error, element) {
          $(element).parent().parent().removeClass('success');
          $(element).parent().parent().addClass('error');
          element.next().remove()
          error.insertAfter(element);
        },
        rules:{
          password: {
            required: true,
            minlength: 5
          },
          confirmPassword: {
            required: true,
            minlength: 5,
            equalTo: "#password"
          }
        },
        messages:{
          password: {
            required: "La nueva contraseña es requerida",
            minlength: "Tu contraseña debe tener al menos 5 caracteres"
          },
          confirmPassword: {
            required: "Confirma tu password",
            minlength: "Tu contraseña debe tener al menos 5 caracteres",
            equalTo: "Tu contraseña no coincide"
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
  <h1><g:message code="login.updatePassword"/>
    <small>Escribe tu nueva contraseña y confirmala</small>
  </h1>
</div>
<g:if test="${flash.messageOk}">
  <div class="alert alert-success">
    <button data-dismiss="alert" class="close" type="button">×</button>
    <strong>Bien!</strong> ${flash.messageOk}
  </div>
</g:if>
<g:form name="updatePassword" action="updatePassword" method="post" controller="user" class="form-horizontal well">
  <g:if test="${email}">
    <g:hiddenField name="email" value="${email}"/>
  </g:if>
  <fieldset>
    <!--div class="field">
    <label for="oldPassword"><g:message code='login.oldPassword'/></label>
    <input type="password" maxlength="25" id="oldPassword" name="oldPassword" value=""/>
    </div-->
    <div class="control-group">
      <label for="password" class="control-label"><g:message code='login.newPassword'/></label>
      <div class="controls">
        <input type="password" maxlength="25" id="password" name="password" value="" class="input-xlarge focused"/>
      </div>
    </div>
    <div class="control-group">
      <label for="confirmPassword" class="control-label"><g:message code='login.confirmpassword'/></label>
      <div class="controls">
        <input type="password" maxlength="25" id="confirmPassword" name="confirmPassword" value="" class="input-xlarge focused"/>
      </div>
    </div>
    <div class="control-group">
      <label class="control-label">&nbsp;</label>
      <div class="controls">
        <input class="btn btn-success" name="sendButton" type="submit" value="${g.message(code: 'login.updatePassword')}"/>
      </div>
    </div>
  </fieldset>
</g:form>

<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.js"></script>
</body>
