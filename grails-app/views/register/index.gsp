<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="wb"/>
  <parameter name="pageHeader" value="${g.message(code: 'user.create', default: 'Signup')}"/>
</head>
<body>
<g:form action="user" method="post">
  <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
  </g:if>
  <g:hasErrors bean="${userdata}">
    <div class="errors">
      <g:renderErrors bean="${userdata}" as="list"/>
    </div>
  </g:hasErrors>
  <div class="dialog">
    <table>
      <tbody>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="email">Email</label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: userdata, field: 'email', 'errors')}">
          <input type="text" maxlength="200" id="email" name="email" value="${fieldValue(bean: userdata, field: 'email')}"/>
        </td>
      </tr>

      <tr class="prop">
        <td valign="top" class="name">
          <label for="password">Password</label>
        </td>
        <td valign="top" class="value ${hasErrors(bean: userdata, field: 'password', 'errors')}">
          <input type="password" maxlength="200" id="password" name="password" value="${fieldValue(bean: userdata, field: 'password')}"/>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
  <div class="buttons">
    <span class="button"><input class="save" type="submit" value="Create"/></span>
  </div>
</g:form>
</body>
</html>
