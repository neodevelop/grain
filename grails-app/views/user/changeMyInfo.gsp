<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='mainContent'/>
  <r:require module="common"/>
  <r:script>
  $(function(){
    $("form#userInfo").validate({
      errorPlacement: function(error, element) {
        $(element).parent().parent().removeClass('success');
        $(element).parent().parent().addClass('error');
        element.next().remove()
        error.insertAfter(element);
      },
      rules:{
        firstName:'required',
        lastName:'required'
      },
      messages:{
        firstName:"${g.message(code:'user.fieldRequired')}",
        lastName:"${g.message(code:'user.fieldRequired')}"
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
  <h1>Actualizar mi perfil
    <small>Dejanos saber un poco más de ti</small>
  </h1>
</div>
<g:form action="save" class="form-horizontal" name="userInfo" id="userInfo">
  <fieldset>
    <div class="control-group">
      <label class="control-label"><g:message code="me.email"/>:</label>
      <div class="controls">
        <span class="input-xlarge uneditable-input">${user.email}</span>
      </div>
    </div>
    <div class="control-group">
      <label for="firstName" class="control-label"><g:message code="me.name"/>:</label>
      <div class="controls">
        <g:textField name="firstName" value="${user.firstName}" class="input-xlarge focused" placeholder="Tu nombre"/>
      </div>
    </div>
    <div class="control-group">
      <label for="lastName" class="control-label"><g:message code="me.lastname"/>:</label>
      <div class="controls">
        <g:textField name="lastName" value="${user.lastName}" class="input-xlarge focused" placeholder="Tus apellidos"/>
      </div>
    </div>
    <div class="control-group">
      <label for="company" class="control-label"><g:message code="me.company"/>:</label>
      <div class="controls">
        <g:textField name="company" value="${user.company}" class="input-xlarge focused" placeholder="Trabajas en..."/>
      </div>
    </div>
    <div class="control-group">
      <label for="website" class="control-label"><g:message code="me.website"/>:</label>
      <div class="controls">
        <g:textField name="website" value="${user.website}" class="input-xlarge focused" placeholder="http://..."/>
      </div>
    </div>
    <div class="form-actions">
      <g:submitButton name="submit" value="Actualizar mi perfil" class="btn btn-primary"/>
      <g:link mapping="me" class="btn">Regresar</g:link>
    </div>
  </fieldset>
  <g:hiddenField name="geolocation" value="${user?.geolocation}"/>
</g:form>

<g:render template="/common/map" model="[refField:'geolocation',width:600,height:300]" />
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.js"></script>
</body>
