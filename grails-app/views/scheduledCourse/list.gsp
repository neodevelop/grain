
<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="wb" />
  <title><g:message code="scheduledCourse.list" default="Scheduled Course List" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'scheduledCourse.list', default: 'Scheduled Course List')}"/>
  <script type="text/javascript" language="javascript" src="${createLinkTo(dir:'js',file:'tables.js')}"></script>
  <script language="javascript">
    $(function(){
      $("div.list table").styleTable();
    });
  </script>
</head>
<body>
<div class="nav">
  <span class="menuButton"><g:link class="create" action="create"><g:message code="scheduledCourse.new" default="New ScheduledCourse" /></g:link></span>
</div>
<br/>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
  </g:if>

  <g:render template="list" model="[scheduledCourseList:scheduledCourseInstanceList,hasPendingPayments:hasPendingPayments]"/>

  <div class="paginateButtons">
    <g:paginate total="${scheduledCourseInstanceTotal}" />
  </div>
</div>
</body>
</html>
