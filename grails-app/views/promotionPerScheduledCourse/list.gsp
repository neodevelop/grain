<%@ page import="com.synergyj.grain.course.PromotionPerScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="mainContent" />
  <title><g:message code="promotionPerScheduledCourse.list" default="PromotionPerScheduledCourse List" /></title>
  <r:require module="common"/>
  <r:require module="paginator"/>
</head>
<body>
  <div class="page-header">
    <h1>${g.message(code: 'promotionPerScheduledCourse.create', default: 'Promo to ScheduledCourse List')}
      <small>Promociones aplicadas a un curso</small>
    </h1>
  </div>

  <g:link class="btn btn-primary" action="create">
    <g:message code="promotionPerScheduledCourse.new" default="New PromotionPerScheduledCourse" />
  </g:link>



  <table width="100%" class="table table-striped">
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
      <tr>
        <td><g:link action="show" id="${promotionPerScheduledCourseInstance.id}">${fieldValue(bean: promotionPerScheduledCourseInstance, field: "id")}</g:link></td>
        <td>${fieldValue(bean: promotionPerScheduledCourseInstance, field: "promotion")}</td>
        <td>${fieldValue(bean: promotionPerScheduledCourseInstance, field: "scheduledCourse.course")}</td>
        <td><g:formatDate date="${promotionPerScheduledCourseInstance.validUntil}" format="EEEE dd/MMMM/yyyy" /></td>
      </tr>
    </g:each>
    </tbody>
  </table>

  <div class="pagination">
    <g:paginate total="${promotionPerScheduledCourseInstanceTotal}" />
  </div>

</body>
</html>
