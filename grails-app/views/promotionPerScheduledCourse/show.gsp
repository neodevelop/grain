
<%@ page import="com.synergyj.grain.course.PromotionPerScheduledCourse" %>
<html>
<head>
  
  <meta name="layout" content="mainContent" />
  <title><g:message code="promotionPerScheduledCourse.show" default="Show PromotionPerScheduledCourse" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'promotionPerScheduledCourse.create', default: 'Show Promo to ScheduledCourse')}"/>
</head>
<body>
<div class="nav">
  <span class="menuButton"><a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home" /></a></span>
  <span class="menuButton"><g:link class="list" action="list"><g:message code="promotionPerScheduledCourse.list" default="PromotionPerScheduledCourse List" /></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="promotionPerScheduledCourse.new" default="New PromotionPerScheduledCourse" /></g:link></span>
</div>
<div class="body">
  <g:form>
    <g:hiddenField name="id" value="${promotionPerScheduledCourseInstance?.id}" />
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="promotionPerScheduledCourse.id" default="Id" />:</td>

          <td valign="top" class="value">${fieldValue(bean: promotionPerScheduledCourseInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="promotionPerScheduledCourse.promotion" default="Promotion" />:</td>

          <td valign="top" class="value"><g:link controller="promotion" action="show" id="${promotionPerScheduledCourseInstance?.promotion?.id}">${promotionPerScheduledCourseInstance?.promotion?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="promotionPerScheduledCourse.scheduledCourse" default="Scheduled Course" />:</td>

          <td valign="top" class="value"><g:link controller="scheduledCourse" action="show" id="${promotionPerScheduledCourseInstance?.scheduledCourse?.id}">${promotionPerScheduledCourseInstance?.scheduledCourse?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="promotionPerScheduledCourse.validUntil" default="Valid Until" />:</td>

          <td valign="top" class="value"><g:formatDate date="${promotionPerScheduledCourseInstance?.validUntil}" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="promotionPerScheduledCourse.dateCreated" default="Date Created" />:</td>

          <td valign="top" class="value"><g:formatDate date="${promotionPerScheduledCourseInstance?.dateCreated}" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="promotionPerScheduledCourse.lastUpdated" default="Last Updated" />:</td>

          <td valign="top" class="value"><g:formatDate date="${promotionPerScheduledCourseInstance?.lastUpdated}" /></td>

        </tr>

        </tbody>
      </table>
    </div>
    <div class="buttons">
      <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
    </div>
  </g:form>
</div>
</body>
</html>
