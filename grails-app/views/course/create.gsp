
<%@ page import="com.synergyj.grain.course.Course" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="wb" />
        <title><g:message code="course.create" default="Create Course" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'course.create', default: 'Create Course')}"/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="course.list" default="Course List" /></g:link></span>
        </div>
        <br/>
        <div class="content">

			      <g:render template="/common/errors" model="[instance:courseInstance]"/>

            <g:form action="save" method="post" name="courseForm" onsubmit="return validateForm(this);">
                <g:render template="courseForm" />
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>

        </div>
    </body>
</html>
