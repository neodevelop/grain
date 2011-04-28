<head>
  <title><g:message code='me.title' default="Me"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'me.title', default: 'This is me')}"/>
</head>
<body>
  <g:link mapping="updateme">Change my profile</g:link>
  <h4>e-m@il:</h4><h3>${user.email}</h3>
  <br>
  <h4>first name:</h4><h3>${user.firstName ?: 'empty'}</h3>
  <br>
  <h4>last name:</h4><h3>${user.lastName ?: 'empty'}</h3>
  <br>
  <h4>company:</h4><h3>${user.company ?: 'empty'}</h3>
  <br>
  <h4>website:</h4><h3>${user.website ?: 'empty'}</h3>
  <br>
  <h4>geolocation:</h4><h3>${user.geolocation ?: 'empty'}</h3>
  <br>
  <g:link mapping="updateme">Change my profile</g:link>
</body>
