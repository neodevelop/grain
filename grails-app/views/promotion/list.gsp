<%@ page import="com.synergyj.grain.course.Promotion" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="mainContent" />
  <title><g:message code="promotion.list" default="Promotion List" /></title>
  <r:require module="common"/>
  <r:require module="paginator"/>
</head>
<body>
  <div class="page-header">
    <h1><g:message code="promotion.list" default="Promotion List" />
      <small>Promociones asignables a cursos calendarizados</small>
    </h1>
  </div>

  <g:link class="btn btn-primary" action="create">
    <g:message code="promotion.new" default="New Promotion" />
  </g:link>

  <table class="table table-striped" width="100%">
    <thead>
      <tr>
        <g:sortableColumn property="id" title="Id" titleKey="promotion.id" />
        <g:sortableColumn property="promotionKey" title="Promotion Key" titleKey="promotion.promotionKey" />
        <g:sortableColumn property="description" title="Description" titleKey="promotion.description" />
        <g:sortableColumn property="discount" title="Discount" titleKey="promotion.discount" />
      </tr>
    </thead>
    <tbody>
    <g:each in="${promotionInstanceList}" status="i" var="promotionInstance">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td><g:link action="show" id="${promotionInstance.id}">${fieldValue(bean: promotionInstance, field: "id")}</g:link></td>
        <td>${fieldValue(bean: promotionInstance, field: "promotionKey")}</td>
        <td>${fieldValue(bean: promotionInstance, field: "description")}</td>
        <td><g:formatNumber number="${promotionInstance.discount}" locale="es_MX" /> %</td>
      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="paginate">
    <g:paginate total="${promotionInstanceTotal}" />
  </div>
</body>
</html>
