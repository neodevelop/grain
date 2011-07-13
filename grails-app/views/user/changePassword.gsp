<%@ page contentType="text/html;charset=UTF-8" %>

<head>
  <title><g:message code='me.changePassword' default="Change my password"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.changePassword', default: 'Change my password')}"/>
  <script type="text/javascript" src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>
  <script type="text/javascript">
    $(function(){
      $("#oldPassword").focus();
      $("#updatePassword").validate({
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
        }
      });
    });
  </script>
</head>
<body>
<div id="bigForm">
  <div id="signup">
    <g:form name="updatePassword" action="updatePassword" method="post" controller="user">

      <div id="registrationInfo">
        <g:message code="login.updatePassword"/>
      </div>

      <!--div class="field">
        <label for="oldPassword"><g:message code='login.oldPassword'/></label>
         <input type="password" maxlength="25" id="oldPassword" name="oldPassword" value=""/>
      </div-->

      <g:if test="${email}">
        <g:hiddenField name="email" value="${email}"/>
      </g:if>

      <div class="field">
        <label for="password"><g:message code='login.newPassword'/></label><br/>
        <input type="password" maxlength="25" id="password" name="password" value=""/>
      </div>

      <div class="field">
        <label for="confirmPassword"><g:message code='login.confirmpassword'/></label><br/>
        <input type="password" maxlength="25" id="confirmPassword" name="confirmPassword" value=""/>
      </div>

      <div class="submit">
        <input class="sendButton" name="sendButton" type="submit" value="${g.message(code: 'login.updatePassword')}"/>
      </div>

    </g:form>
  </div>
</div>
</body>
