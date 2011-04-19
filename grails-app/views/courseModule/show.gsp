
<%@ page import="com.synergyj.grain.course.CourseModule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="courseModule.show" default="Show CourseModule" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="courseModule.list" default="CourseModule List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="courseModule.new" default="New CourseModule" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="courseModule.show" default="Show CourseModule" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${courseModuleInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: courseModuleInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: courseModuleInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.content" default="Content" />:</td>
                                
                                <td valign="top" class="value">${courseModuleInstance?.content}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.contentType" default="Content Type" />:</td>
                                
                                <td valign="top" class="value">${courseModuleInstance?.contentType?.encodeAsHTML()}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${courseModuleInstance?.lastUpdated}" format="dd-MM-yy hh:mm" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${courseModuleInstance?.dateCreated}" format="dd-MM-yy hh:mm" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.course" default="Course" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="course" action="show" id="${courseModuleInstance?.course?.id}">${courseModuleInstance?.course?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.order" default="Order" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: courseModuleInstance, field: "order")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="courseModule.topics" default="Topics" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${courseModuleInstance?.topics}" var="moduleTopicInstance">
                                        <li><g:link controller="moduleTopic" action="show" id="${moduleTopicInstance.id}">${moduleTopicInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
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
