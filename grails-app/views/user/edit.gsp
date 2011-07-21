<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.title', default: 'This is me')}"/>
  <script src="http://jquery.bassistance.de/validate/jquery.validate.js" type="text/javascript"></script>
  <script language="javascript">
  $(function(){
    $("form#userInfo").validate({
      rules:{
        firstName:'required',
        lastName:'required'
      },
      messages:{
        firstName:"${g.message(code:'user.fieldRequired')}",
        lastName:"${g.message(code:'user.fieldRequired')}"
      }
    });
  });
  </script>
</head>
<body>
<div id="left">
  <g:form action="save" class="form" name="userInfo" id="userInfo">
  <h4><g:message code="me.email"/>:</h4>
  <h3>${user.email}</h3>
  <br>
  <h4><g:message code="me.name"/>:</h4>
    <g:textField name="firstName" value="${user.firstName}"/>
  <br>
  <h4><g:message code="me.lastname"/>:</h4>
    <g:textField name="lastName" value="${user.lastName}"/>
  <br>
  <h4><g:message code="me.company"/>:</h4>
    <g:textField name="company" value="${user.company}"/>
  <br>
  <h4><g:message code="me.website"/>:</h4>
    <g:textField name="website" value="${user.website}"/>
  <br>
  <br/>
  <g:hiddenField name="geolocation" value="${user?.geolocation}"/>
  <g:submitButton name="submit" value="Actualizar" class="submit"/>
  <g:link mapping="me" class="action">Regresar</g:link>
  </g:form>
</div>
<div id="right">
  <g:render template="/common/map" model="[refField:'geolocation',width:600,height:300]" />
</div>
</body>
