<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="mainContent" />
  <title><g:message code="course.show" default="Show Course" /></title>
  
  <r:require module="common"/>
</head>
<body>
  <div class="page-header">
    <h1>${fieldValue(bean: courseInstance, field: "name")}
      <small>${fieldValue(bean: courseInstance, field: "urlLandingPage")}</small>
    </h1>
  </div>
  
  <g:link action="list" class="btn">
    <g:message code="course.list" default="Course List" />
  </g:link>
  <g:link action="create" class="btn">
    <g:message code="course.new" default="New Course" />
  </g:link>

  <g:form>
  <g:hiddenField name="id" value="${courseInstance?.id}" />
  <dl>

    <dt><g:message code="course.content" default="Content" />:</dt>
    <dd>${courseInstance?.content}</dd>

    <dt><g:message code="course.contentType" default="Content Type" />:</dt>
    <dd>${courseInstance?.contentType?.encodeAsHTML()}</dd>

  
    <dt><g:message code="course.lastUpdated" default="Last Updated" />:</dt>
    <dd><g:formatDate date="${courseInstance?.lastUpdated}" format="dd-MM-yy" /></dd>

    <dt><g:message code="course.dateCreated" default="Date Created" />:</dt>
    <dd><g:formatDate date="${courseInstance?.dateCreated}" format="dd-MM-yy" /></dd>
  
    <dt><g:message code="course.overview" default="Overview" />:</dt>
    <dd>${courseInstance?.overview}</dd>
  
    <dt><g:message code="course.audience" default="Audience" />:</dt>
    <dd>${courseInstance?.audience}</dd>
  
    <dt><g:message code="course.prerequisites" default="Prerequisites" />:</dt>
    <dd>${courseInstance?.prerequisites}</dd>
  
    <dt><g:message code="course.goal" default="Goal" />:</dt>
    <dd>${courseInstance?.goal}</dd>
  
    <dt><g:message code="course.method" default="Method" />:</dt>
    <dd>${courseInstance?.method}</dd>
  
    <dt><g:message code="course.format" default="Format" />:</dt>
    <dd>${courseInstance?.format}</dd>
  
    <dt><g:message code="course.courseKey" default="Course Key" />:</dt>
    <dd>${fieldValue(bean: courseInstance, field: "courseKey")}</dd>
  
    <dt><g:message code="course.courseType" default="Course Type" />:</dt>
    <dd>${courseInstance?.courseType?.encodeAsHTML()}</dd>
  
    <dt><g:message code="course.status" default="Status" />:</dt>
    <dd>${courseInstance?.status?.encodeAsHTML()}</dd>
  
    <dt><g:message code="course.modules" default="Modules" />:</dt>
    <dd>
    <ul>
      <g:each in="${courseInstance?.modules}" var="courseModuleInstance">
        <li><g:link controller="courseModule" action="show" id="${courseModuleInstance.id}">${courseModuleInstance.encodeAsHTML()}</g:link></li>
      </g:each>
    </ul>
  </dd>
  </dl>
  <div class="form-actions">
    <g:actionSubmit class="btn" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" />
    <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
  </div>
  </g:form>
</div>
</body>
</html>
