
<%@ page import="com.synergyj.grain.course.Promotion" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="wb" />
  <title><g:message code="promotion.list" default="Promotion List" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'promotion.list', default: 'Promotion List')}"/>
  <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'tables.js')}"></script>
  <script language="javascript">
    $(function(){
      $("div.list table").styleTable();
    });
  </script>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home" /></a></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="promotion.new" default="New Promotion" /></g:link></span>
</div>
<br/>
<div class="body">
  <div class="list">
    <table cellspacing="0" cellpadding="5" width="100%">
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

          <td><g:formatNumber number="${promotionInstance.discount}" locale="es_MX" format="\$ ###,##0.00"/></td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${promotionInstanceTotal}" />
  </div>
</div>
</body>
</html>
