<%@ page import="com.synergyj.grain.content.Content" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="content.create" default="Create Content"/></title>
  <link rel="stylesheet" type="text/css" href="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.css"/>
  
</head>
<body>

  <g:link class="btn" action="list"><g:message code="content.list" default="Content List"/></g:link>

  <div class="page-header">
    <h1>${g.message(code: 'content.create', default: 'Create Content')}
      <small>&nbsp;</small>
    </h1>
  </div>

  <g:hasErrors bean="${contentInstance}">
    <div class="errors">
      <g:renderErrors bean="${contentInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form action="save" method="post">
    <g:render template="form" model="contentInstance:contentInstance" />
    <div class="form-actions">
      <g:submitButton name="create" class="btn" value="${message(code: 'create', 'default': 'Create')}"/>
    </div>
  </g:form>

  <!-- Script para el WYSIWYG -->
  <script type="text/javascript" src="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.js"></script>
  <!-- Aplicamos el wysiwyg a los textarea y button al menu -->
  <script language="javascript">
  $(function(){
    $('textarea.wysiwyg').wysiwyg({
      controls:{
        html  : { visible: true }
      }
    });
  });
  </script>

</body>
</html>
