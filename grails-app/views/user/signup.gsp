<head>
  <meta name="layout" content="main"/>
  
  <title><g:message code="user.signup" default="User signup" /></title>
  <r:script>
    $(function(){
      <g:if test="${registrationCode}">
        $("#password").focus();
      </g:if>
      <g:else>
        $("#email").focus();
      </g:else>
      $("#registerForm").validate({
        errorPlacement: function(error, element) {
          $(element).parent().removeClass('success');
          $(element).parent().addClass('error');
          error.insertAfter(element);
        },
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
        },
        validClass: "success"
      });
      $("input").blur(function(){
        if($(this).hasClass('success'))
          $(this).parent().addClass('success');
      });
      $(":checkbox").change(function(){
        if($(this).hasClass('success')){
          $(this).parent().addClass('success');
          $(this).parent().removeClass('error');
        } else {
          $(this).parent().addClass('error');
          $(this).parent().removeClass('success');
        }
      });
    });
  </r:script>

</head>
<body>

<div class="page-header">
  <h1>Signup
    <small>${message(code:'register.alt',default:"Creating a user account allows you to enroll yourself in training events.")}</small>
  </h1>
</div>

<div class="row">
  
  <div class="span6">
    <h2>Información básica</h2>
    <p>Una notificación será enviada a tu correo</p>

    <g:if test="${flash.error}">
      <div class="alert alert-error">
        ${flash.error}
      </div>
    </g:if>

    <g:form name="registerForm" action="user" method="post" controller="register" class="well">

      <div class="control-group">
        <label class="control-label"><g:message code='login.username'/></label>
        <g:if test="${registrationCode}">
          <input type="text" id="emailShow" name="emailShow" value="${registrationCode?.username}" disabled="disabled" class="span3"/>
          <input type="hidden" id="email" name="email" value="${registrationCode?.username}"/>
        </g:if>
        <g:else>
          <input type="text" id="email" name="email" value="${fieldValue(bean: userdata, field: 'email')}" class="span3" placeholder="you@email.com"/>
        </g:else>
      </div>
      
      <div class="control-group">
        <label class="control-label" for="password"><g:message code='login.password'/></label>
        <input type="password" maxlength="200" id="password" name="password" value="${fieldValue(bean: userdata, field: 'password')}" class="span3" placeholder="Password"/>
      </div>

      <div class="control-group">
        <label class="control-label" for="confirmPassword"><g:message code='login.confirmpassword'/></label>
        <input type="password" maxlength="200" id="confirmPassword" name="confirmPassword" value="${fieldValue(bean: userdata, field: 'password')}" class="span3" placeholder="The same above here..."/>
      </div>

      <div class="control-group">
        <g:checkBox name="tos" id="tos" checked="${fieldValue(bean: userdata, field: 'tos')}" />
        <label id="tosLabel" class="control-label" for="tos">
          <g:message code='login.tos' default="Terms of Service"/>
        </label>
      </div>

      <input class="btn btn-primary" name="sendButton" type="submit" value="${g.message(code: 'login.register')}"/>

      <g:if test="${scheduledCourse}">
        <g:hiddenField name="scheduledCourseId" value="${scheduledCourse.id}"/>
      </g:if>

    </g:form>

  </div>
  <div class="span6">
    <g:if test="${scheduledCourse}">
      <g:render template="/scheduledCourse/show" model="[scheduledCourse:scheduledCourse]"/>
      
    </g:if>      
  </div>
</div>


<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.js"></script>
  
</body>