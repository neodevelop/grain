
<%@ page import="com.synergyj.grain.course.PromotionPerScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="wb" />
  <title><g:message code="promotionPerScheduledCourse.create" default="Add Promo to ScheduledCourse" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'promotionPerScheduledCourse.create', default: 'Add Promo to ScheduledCourse')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home" /></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="promotionPerScheduledCourse.list" default="PromotionPerScheduledCourse List" /></g:link></span>
</div>
<div class="body">
  <g:hasErrors bean="${promotionPerScheduledCourseInstance}">
    <div class="errors">
      <g:renderErrors bean="${promotionPerScheduledCourseInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form action="save" method="post" >
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="promotion"><g:message code="promotionPerScheduledCourse.promotion" default="Promotion" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: promotionPerScheduledCourseInstance, field: 'promotion', 'errors')}">
            <g:select name="promotion.id" from="${com.synergyj.grain.course.Promotion.list()}" optionKey="id" value="${promotionPerScheduledCourseInstance?.promotion?.id}"  />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="scheduledCourse"><g:message code="promotionPerScheduledCourse.scheduledCourse" default="Scheduled Course" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: promotionPerScheduledCourseInstance, field: 'scheduledCourse', 'errors')}">
            <g:select name="scheduledCourse.id" from="${com.synergyj.grain.course.ScheduledCourse.list()}" optionKey="id" value="${promotionPerScheduledCourseInstance?.scheduledCourse?.id}"  />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="validUntil"><g:message code="promotionPerScheduledCourse.validUntil" default="Valid Until" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: promotionPerScheduledCourseInstance, field: 'validUntil', 'errors')}">
            <g:datePicker name="validUntil" value="${promotionPerScheduledCourseInstance?.validUntil}"  />
          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
    </div>
  </g:form>
</div>
</body>
</html>
