<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.title', default: 'This is me')}"/>
</head>
<body>
  <g:form action="save" class="form">
  <h4>e-m@il:</h4>
  <h3>${user.email}</h3>
  <br>
  <h4>first name:</h4>
    <g:textField name="firstName" value="${user.firstName}"/>
  <br>
  <h4>last name:</h4>
    <g:textField name="lastName" value="${user.lastName}"/>
  <br>
  <h4>company:</h4>
    <g:textField name="company" value="${user.company}"/>
  <br>
  <h4>website:</h4>
    <g:textField name="website" value="${user.website}"/>
  <br>
  <h4>geolocation:</h4>
    <g:textField name="geolocation" value="${user.geolocation}"/>
  <br/>
  <br/>
  <g:link mapping="me">Cancel and return</g:link>
  <g:submitButton name="submit" value="Update info" class="submit"/>
  </g:form>
</body>
