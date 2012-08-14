
<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="mainContent" />
  <title><g:message code="course.edit" default="Edit Course" /></title>
  <!-- Hoja de estilo para el WYSIWYG  -->
  <link rel="stylesheet" type="text/css" href="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.css"/>
  <r:require module="common"/>
</head>
<body>
  <div class="page-header">
    <h1>${g.message(code: 'course.edit', default: 'Edit Course')}
      <small>Modifcando los datos del curso</small>
    </h1>
  </div>

  <g:link class="btn" action="list">
    <g:message code="course.list" default="Course List" />
  </g:link>
  <g:link class="btn" action="create">
    <g:message code="course.new" default="New Course" />
  </g:link>

  <g:form method="post" name="courseForm" onsubmit="return validateForm(this);" class="form-horizontal">
    <g:hiddenField name="id" value="${courseInstance?.id}" />
    <g:hiddenField name="version" value="${courseInstance?.version}" />
    <g:render template="courseForm" />
    <div class="form-actions">
      <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'update', 'default': 'Update')}" />
      <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
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
