
<%@ page import="com.synergyj.grain.course.PromotionPerScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="wb" />
  <title><g:message code="promotionPerScheduledCourse.list" default="PromotionPerScheduledCourse List" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'promotionPerScheduledCourse.create', default: 'Promo to ScheduledCourse List')}"/>
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
  <span class="menuButton"><g:link class="create" action="create"><g:message code="promotionPerScheduledCourse.new" default="New PromotionPerScheduledCourse" /></g:link></span>
</div>
<br/>
<div class="body">
  <div class="list">
    <table width="100%" cellpadding="5" cellspacing="0">
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="promotionPerScheduledCourse.id" />

        <th><g:message code="promotionPerScheduledCourse.promotion" default="Promotion" /></th>

        <th><g:message code="promotionPerScheduledCourse.scheduledCourse" default="Scheduled Course" /></th>

        <g:sortableColumn property="validUntil" title="Valid Until" titleKey="promotionPerScheduledCourse.validUntil" />

      </tr>
      </thead>
      <tbody>
      <g:each in="${promotionPerScheduledCourseInstanceList}" status="i" var="promotionPerScheduledCourseInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${promotionPerScheduledCourseInstance.id}">${fieldValue(bean: promotionPerScheduledCourseInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: promotionPerScheduledCourseInstance, field: "promotion")}</td>

          <td>${fieldValue(bean: promotionPerScheduledCourseInstance, field: "scheduledCourse")}</td>

          <td><g:formatDate date="${promotionPerScheduledCourseInstance.validUntil}" format="EEEE dd/MMMM/yyyy" /></td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${promotionPerScheduledCourseInstanceTotal}" />
  </div>
</div>
</body>
</html>
