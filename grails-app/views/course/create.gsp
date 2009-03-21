
<%@ page import="com.synergyj.grain.domain.Course" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="course.create" default="Create Course" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="course.list" default="Course List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="course.create" default="Create Course" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${courseInstance}">
            <div class="errors">
                <g:renderErrors bean="${courseInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="course.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${fieldValue(bean: courseInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content"><g:message code="course.content" default="Content" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'content', 'errors')}">
                                    <g:textField name="content" value="${fieldValue(bean: courseInstance, field: 'content')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contentType"><g:message code="course.contentType" default="Content Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'contentType', 'errors')}">
                                    <g:select name="contentType" from="${com.synergyj.grain.content.ContentType?.values()}" value="${courseInstance?.contentType}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="courseType"><g:message code="course.courseType" default="Course Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'courseType', 'errors')}">
                                    <g:select name="courseType" from="${com.synergyj.grain.domain.CourseType?.values()}" value="${courseInstance?.courseType}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="course.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${com.synergyj.grain.domain.Status?.values()}" value="${courseInstance?.status}"  />

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
