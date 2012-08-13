<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="mainContent" />
  <title><g:message code="course.create" default="Create Course" /></title>
  <!-- Hoja de estilo para el WYSIWYG  -->
  <link rel="stylesheet" type="text/css" href="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.css"/>
  <r:require module="common"/>
</head>
<body>
  <div class="page-header">
    <h1>${g.message(code: 'course.create', default: 'Create Course')}
      <small>Los datos del curso</small>
    </h1>
  </div>

  <g:form action="save" method="post" name="courseForm" onsubmit="return validateForm(this);" class="form-horizontal">
    <g:render template="courseForm" />
    <div class="form-actions">
      <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'create', 'default': 'Create')}" />
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
