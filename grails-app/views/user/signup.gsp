<head>
  <meta name="layout" content="wb"/>
  <parameter name="pageHeader" value="${g.message(code: 'user.signup', default: 'Signup')}"/>
  <g:javascript library="jquery" plugin="jquery"/>
  <script type="text/javascript" src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>
  <g:javascript>
    $(function(){
      <g:if test="${registrationCode}">
        $("#password").focus();
      </g:if>
      <g:else>
        $("#email").focus();
      </g:else>
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
<g:if test="${scheduledCourse}">
  <div id="floatingMessage">
    <img src="<g:createLinkTo dir='themes/wb/images' file='icon_student.png'/>" alt="course" title="course"/>
    <i>Curso:</i> <b>${scheduledCourse.course.name}</b><br/>
    <img src="<g:createLinkTo dir='themes/wb/images' file='icon_calendar.png'/>" alt="course" title="course"/>
    <i>Inicia:</i> <b><g:formatDate date="${scheduledCourse.beginDate}" format="EEEE dd 'de' MMMM 'del' yyyy"/></b>
  </div>
</g:if>
<g:render template="/common/errors" model="[instance:userdata]"/>

<div id="bigForm">
  <div id="signup">
    <g:form name="registerForm" action="user" method="post" controller="register">

      <div id="registrationInfo">
        <g:message code="register.alt" default="Creating a user account allows you to enroll yourself in training events."/>
      </div>

      <div class="field">
        <label for="email"><g:message code='login.username'/></label>
        <g:if test="${registrationCode}">
          <input type="text" id="emailShow" name="emailShow" value="${registrationCode?.username}" disabled="disabled"/>
          <input type="hidden" id="email" name="email" value="${registrationCode?.username}"/>
        </g:if>
        <g:else>
          <input type="text" id="email" name="email" value="${fieldValue(bean: userdata, field: 'email')}"/>
        </g:else>
      </div>

      <div class="field">
        <label for="password"><g:message code='login.password'/></label><br/>
        <input type="password" maxlength="200" id="password" name="password" value="${fieldValue(bean: userdata, field: 'password')}"/>
      </div>

      <div class="field">
        <label for="confirmPassword"><g:message code='login.confirmpassword'/></label><br/>
        <input type="password" maxlength="200" id="confirmPassword" name="confirmPassword" value="${fieldValue(bean: userdata, field: 'password')}"/>
      </div>

      <div class="tos">
        <label for="tos">
          <g:message code='login.tos' default="Terms of Service"/>
        </label>
        <g:checkBox name="tos" id="tos" checked="${fieldValue(bean: userdata, field: 'tos')}" />
      </div>

      <div class="submit">
        <input class="sendButton" name="sendButton" type="submit" value="${g.message(code: 'login.register')}"/>
      </div>

      <g:if test="${scheduledCourse}">
        <g:hiddenField name="scheduledCourseId" value="${scheduledCourse.id}"/>
      </g:if>

    </g:form>
  </div>
</div>
</body>