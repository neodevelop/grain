<head>
  <meta name="layout" content="wb"/>
  <parameter name="pageHeader" value="${g.message(code: 'user.signup', default: 'Signup')}"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <script type="text/javascript" src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>
  <g:javascript>
    $(function(){
      $("#registerForm").validate({
        rules:{
          email:{
            required:true,
            email:true
          },
          password: {
				    required: true,
				    minlength: 5
			    },
			    confirmPassword: {
				    required: true,
				    minlength: 5,
				    equalTo: "#password"
			    },
          tos: "required"
        },
        messages:{
          email:{
            required:"El correo electrónico es requerido",
            email:"La dirección de correo ingresada no es válida"
          },
          password: {
				    required: "La contraseña es requerida",
				    minlength: "Tu contraseña debe tener al menos 5 caracteres"
			    },
			    confirmPassword: {
				    required: "Confirma tu password",
				    minlength: "Tu contraseña debe tener al menos 5 caracteres",
				    equalTo: "Tu contraseña no coincide"
			    },
          tos: "Por favor acepta nuestra política"
        }
      });
    });
  </g:javascript>
</head>
<body>
<g:render template="/common/errors" model="[instance:userdata]"/>

<g:form name="registerForm" action="user" method="post" controller="register">

  <div class="form-wrapper" id="signup">
    <div id="sign-up">
      <p class="alt-login">%{--Or log in directly with your <a href="/login">OpenID--}%</a></p>
      <div align="center" id="registrationInfo">
        <h4><g:message code="register.alt" default="Creating a user account allows you to enroll yourself in training events."/></h4>
      </div>
      <ul>
        <li>
          <label for="email"><g:message code='login.username'/></label>
          <input type="text" id="email" name="email" value="${fieldValue(bean: userdata, field: 'email')}"/>
        </li>
        <li>
          <label for="password"><g:message code='login.password'/></label><br/>
          <input type="password" maxlength="200" id="password" name="password" value="${fieldValue(bean: userdata, field: 'password')}"/>
        </li>
        <li>
          <label for="confirmPassword"><g:message code='login.confirmpassword'/></label><br/>
          <input type="password" maxlength="200" id="confirmPassword" name="confirmPassword" value="${fieldValue(bean: userdata, field: 'password')}"/>
        </li>
        <li>
          <div class="tos">
            <g:checkBox name="tos" id="tos" checked="${fieldValue(bean: userdata, field: 'tos')}" />
            <label for="tos">
            <a href="${g.createLink(mapping: 'tos')}" target="_blank"><g:message code='login.tos' default="Terms of Service"/></a>
          </label>
          </div>
          <div class="submit">
            <input class="sendButton" name="sendButton" type="submit" value="${g.message(code: 'login.register')}"/>
          </div>

        </li>
      </ul>

    </div>

  </div>
</g:form>
</body>