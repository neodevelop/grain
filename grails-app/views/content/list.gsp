<%@ page import="com.synergyj.grain.content.Content" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title>${g.message(code: 'content.list', default: 'Content List')}</title>
  <r:require module="common"/>
  <r:require module="paginator"/>
  <r:script>
  $(function(){
    $("table.table tbody tr td.bodyText").each(function(){
      var text = $(this).text();
      $(this).text($.trim(text).substring(0,50).split(" ").slice(0,-1).join(" ") + "...");
    });
  })
  </r:script>
</head>
<body>

  <div class="page-header">
    <h1>${g.message(code: 'content.list', default: 'Content List')}
      <small>Contenidos estáticos para el sitio</small>
    </h1>
  </div>


  <g:link class="btn btn-primary" action="create">
    <g:message code="content.new" default="New Content"/>
  </g:link>


  <table class="table table-striped">
    <thead>
      <tr>
        <g:sortableColumn property="id" title="Id" titleKey="content.id"/>
        <g:sortableColumn property="title" title="Title" titleKey="content.title"/>
        <g:sortableColumn property="body" title="Body" titleKey="content.body"/>
        <g:sortableColumn property="language" title="Language" titleKey="content.language"/>
        <g:sortableColumn property="key" title="Key" titleKey="content.key"/>
        <th><g:message code="content.author" default="Author"/></th>
      </tr>
    </thead>
    <tbody>
    <g:each in="${contentInstanceList}" status="i" var="contentInstance">
      <tr>
        <td><g:link action="show" id="${contentInstance.id}">${fieldValue(bean: contentInstance, field: "id")}</g:link></td>
        <td>${fieldValue(bean: contentInstance, field: "title")}</td>
        <td class="bodyText">${fieldValue(bean: contentInstance, field: "body")}</td>
        <td>${fieldValue(bean: contentInstance, field: "language")}</td>
        <td>${fieldValue(bean: contentInstance, field: "key")}</td>
        <td>${fieldValue(bean: contentInstance, field: "author")}</td>
      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="paginateButtons">
    <g:paginate total="${contentInstanceTotal}"/>
  </div>

</body>
</html>
