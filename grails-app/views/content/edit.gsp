<%@ page import="com.synergyj.grain.content.Content" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="content.edit" default="Edit Content"/></title>
  <link rel="stylesheet" type="text/css" href="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.css"/>
  
</head>
<body>

  <g:link class="btn" action="list"><g:message code="content.list" default="Content List"/></g:link>
  <g:link class="btn" action="create"><g:message code="content.new" default="New Content"/></g:link>

  <div class="page-header">
    <h1>${g.message(code: 'content.edit', default: 'Edit Content')}
      <small>&nbsp;</small>
    </h1>
  </div>

  <g:hasErrors bean="${contentInstance}">
    <div class="errors">
      <g:renderErrors bean="${contentInstance}" as="list"/>
    </div>
  </g:hasErrors>
  <g:form method="post">
    <g:hiddenField name="id" value="${contentInstance?.id}"/>
    <g:hiddenField name="version" value="${contentInstance?.version}"/>
    <g:render template="form" model="contentInstance:contentInstance" />
    <div class="form-actions">
      <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'update', 'default': 'Update')}"/>
      <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');"/>
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
