<%@ page contentType="text/html;charset=UTF-8" %>

<head>
  <title><g:message code='me.forgotPassword' default="Forgot my password"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.forgotPassword', default: 'Forgot my password')}"/>
  <script type="text/javascript" src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>
  <script type="text/javascript">
    $(function(){
      $("#oldPassword").focus();
      $("#updatePassword").validate({
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
        }
      });
    });
  </script>
</head>
<body>
<div id="bigForm">
  <div id="signup">
    <g:form name="resetPassword" action="sendResetInstructions" method="post" controller="user">

      <div id="registrationInfo">
        <g:message code="login.forgotPassword"/>
      </div>

      <div class="field">
        <label for="email"><g:message code='login.username'/></label>
        <input type="text" id="email" name="email" value=""/>
      </div>

      <div class="submit">
        <input class="sendButton" name="sendButton" type="submit" value="${g.message(code: 'login.recoverPassword')}"/>
      </div>

    </g:form>
  </div>
</div>
</body>
