<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.title', default: 'This is me')}"/>
  <script src="http://jquery.bassistance.de/validate/jquery.validate.js" type="text/javascript"></script>
  <g:javascript>
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
  </g:javascript>
</head>
<body>
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
  <g:submitButton name="submit" value="Update info" class="submit"/>
  <g:link mapping="me" class="action">Cancel and return</g:link>
  </g:form>
</body>
