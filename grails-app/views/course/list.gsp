<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="mainContent" />
  <title><g:message code="course.list" default="Course List" /></title>
  <r:require module="common"/>
  <r:script>
  $(function(){
    var links = $("div.pagination").children();
    links.wrapAll("<ul/>");
    links.each(function(){
      $(this).wrap("<li/>");
    });
    var active = $("span.currentStep");
    active.parent().addClass("active");
    active.wrap("<a href='#'/>");
  });
  </r:script>
</head>
<body>
  <div class="page-header">
    <h1>${g.message(code: 'course.list', default: 'Course List')}
      <small>Cátalogo de cursos disponibles</small>
    </h1>
  </div>
  <g:link class="btn btn-primary" action="create">
    <g:message code="course.new" default="New Course" />
  </g:link>
  <table class="table table-striped" width="100%">
    <thead>
      <tr>
        <g:sortableColumn property="name" title="Name" titleKey="course.name" />
        <th><g:message code="course.contentType" default="Content Type" /></th>
        <g:sortableColumn property="courseKey" title="Course Key" titleKey="course.courseKey" />
        <g:sortableColumn property="status" title="Course status" titleKey="course.status" />
      </tr>
    </thead>
    <tbody>
    <g:each in="${courseInstanceList}" status="i" var="courseInstance">
      <tr>
        <td width="40%"><g:link action="show" id="${courseInstance.id}">${fieldValue(bean: courseInstance, field: "name")}</g:link></td>
        <td>${fieldValue(bean: courseInstance, field: "contentType")}</td>
        <td>${fieldValue(bean: courseInstance, field: "courseKey")}</td>
        <td>${fieldValue(bean: courseInstance, field: "status")}</td>
      </tr>
    </g:each>
    </tbody>
  </table>
  <div class="pagination">
    <g:paginate total="${courseInstanceTotal}" />
  </div>
</body>
</html>
