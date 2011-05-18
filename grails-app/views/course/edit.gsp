
<%@ page import="com.synergyj.grain.course.Course" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="wb" />
        <title><g:message code="course.edit" default="Edit Course" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'course.edit', default: 'Edit Course')}"/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="course.list" default="Course List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="course.new" default="New Course" /></g:link></span>
        </div>
        <div class="content">
            
			      <g:render template="/common/errors" model="[instance:courseInstance]"/>
			
            <g:form method="post" name="courseForm" onsubmit="return validateForm(this);">
                <g:hiddenField name="id" value="${courseInstance?.id}" />
                <g:hiddenField name="version" value="${courseInstance?.version}" />
               <g:render template="courseForm" />
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
