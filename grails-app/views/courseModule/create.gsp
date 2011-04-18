
<%@ page import="com.synergyj.grain.course.CourseModule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="courseModule.create" default="Create CourseModule" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="courseModule.list" default="CourseModule List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="courseModule.create" default="Create CourseModule" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${courseModuleInstance}">
            <div class="errors">
                <g:renderErrors bean="${courseModuleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="courseModule.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseModuleInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${fieldValue(bean: courseModuleInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content"><g:message code="courseModule.content" default="Content" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseModuleInstance, field: 'content', 'errors')}">
                                    <g:textField name="content" value="${fieldValue(bean: courseModuleInstance, field: 'content')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contentType"><g:message code="courseModule.contentType" default="Content Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseModuleInstance, field: 'contentType', 'errors')}">
                                    <g:select name="contentType" from="${com.synergyj.grain.content.ContentType?.values()}" value="${courseModuleInstance?.contentType}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="course"><g:message code="courseModule.course" default="Course" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseModuleInstance, field: 'course', 'errors')}">
                                    <g:select name="course.id" from="${com.synergyj.grain.course.Course.list()}" optionKey="id" value="${courseModuleInstance?.course?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="order"><g:message code="courseModule.order" default="Order" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseModuleInstance, field: 'order', 'errors')}">
                                    <g:textField name="order" value="${fieldValue(bean: courseModuleInstance, field: 'order')}" />

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
