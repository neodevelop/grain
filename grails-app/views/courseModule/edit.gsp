
<%@ page import="com.synergyj.grain.course.CourseModule" %>
<html>
    <head>
        
        <meta name="layout" content="mainContent" />
        <title><g:message code="courseModule.edit" default="Edit CourseModule" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'courseModule.edit', default: 'Change Course Module')}"/>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="courseModule.list" default="CourseModule List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="courseModule.new" default="New CourseModule" /></g:link></span>
        </div>
        <div class="body">

            <g:form method="post" >
                <g:hiddenField name="id" value="${courseModuleInstance?.id}" />
                <g:hiddenField name="version" value="${courseModuleInstance?.version}" />
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
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="topics"><g:message code="courseModule.topics" default="Topics" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: courseModuleInstance, field: 'topics', 'errors')}">
                                    
<ul>
<g:each in="${courseModuleInstance?.topics}" var="moduleTopicInstance">
    <li><g:link controller="moduleTopic" action="show" id="${moduleTopicInstance.id}">${moduleTopicInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="moduleTopic" params="['courseModule.id': courseModuleInstance?.id]" action="create"><g:message code="moduleTopic.new" default="New ModuleTopic" /></g:link>


                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
