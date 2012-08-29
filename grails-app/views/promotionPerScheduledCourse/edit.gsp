
<%@ page import="com.synergyj.grain.course.PromotionPerScheduledCourse" %>
<html>
<head>
  
  <meta name="layout" content="mainContent" />
  <title><g:message code="promotionPerScheduledCourse.edit" default="Edit PromotionPerScheduledCourse" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'promotionPerScheduledCourse.create', default: 'Edit Promo to ScheduledCourse')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home" /></a>
  <g:link class="btn" action="list"><g:message code="promotionPerScheduledCourse.list" default="PromotionPerScheduledCourse List" /></g:link>
  <g:link class="create" action="create"><g:message code="promotionPerScheduledCourse.new" default="New PromotionPerScheduledCourse" /></g:link>
</div>
<div class="body">
  <g:hasErrors bean="${promotionPerScheduledCourseInstance}">
    <div class="errors">
      <g:renderErrors bean="${promotionPerScheduledCourseInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form method="post" >
    <g:hiddenField name="id" value="${promotionPerScheduledCourseInstance?.id}" />
    <g:hiddenField name="version" value="${promotionPerScheduledCourseInstance?.version}" />
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
    <div class="form-actions">
      <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'update', 'default': 'Update')}" />
      <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
    </div>
  </g:form>
</div>
</body>
</html>
