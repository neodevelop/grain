
<%@ page import="com.synergyj.grain.course.CourseModule" %>
<html>
    <head>
        
        <meta name="layout" content="mainContent" />
        <title><g:message code="courseModule.create" default="Create CourseModule" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'courseModule.create', default: 'Create Course Module')}"/>
    </head>
    <body>
        <div class="nav">
            <g:link class="btn" action="list"><g:message code="courseModule.list" default="CourseModule List" /></g:link>
        </div>
        <div class="body">
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
                                    <g:textArea name="content" rows="5" cols="70">${courseModuleInstance?.content}</g:textArea>
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
                                    <g:select from="${1..99}" name="order" value="${fieldValue(bean: courseModuleInstance, field: 'order')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="${message(code: 'create', 'default': 'Create')}" />
                </div>
            </g:form>
        </div>
    </body>
</html>
