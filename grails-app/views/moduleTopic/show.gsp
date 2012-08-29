
<%@ page import="com.synergyj.grain.course.ModuleTopic" %>
<html>
    <head>
        
        <meta name="layout" content="mainContent" />
        <title><g:message code="moduleTopic.show" default="Show ModuleTopic" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'moduleTopic.show', default: 'Show Module Topic')}"/>
    </head>
    <body>
        <div class="nav">
            <g:link class="btn" action="list"><g:message code="moduleTopic.list" default="ModuleTopic List" /></g:link>
            <g:link class="create" action="create"><g:message code="moduleTopic.new" default="New ModuleTopic" /></g:link>
        </div>
        <div class="body">

            <g:form>
                <g:hiddenField name="id" value="${moduleTopicInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: moduleTopicInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: moduleTopicInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.content" default="Content" />:</td>
                                
                                <td valign="top" class="value">${moduleTopicInstance?.content}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.contentType" default="Content Type" />:</td>
                                
                                <td valign="top" class="value">${moduleTopicInstance?.contentType?.encodeAsHTML()}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${moduleTopicInstance?.lastUpdated}" format="dd-MM-yy hh:mm" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${moduleTopicInstance?.dateCreated}" format="dd-MM-yy hh:mm" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.module" default="Module" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="courseModule" action="show" id="${moduleTopicInstance?.module?.id}">${moduleTopicInstance?.module?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.parent" default="Parent" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="moduleTopic" action="show" id="${moduleTopicInstance?.parent?.id}">${moduleTopicInstance?.parent?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.order" default="Order" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: moduleTopicInstance, field: "order")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="moduleTopic.topics" default="Topics" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${moduleTopicInstance?.topics}" var="moduleTopicInstance">
                                        <li><g:link controller="moduleTopic" action="show" id="${moduleTopicInstance.id}">${moduleTopicInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="form-actions">
                    <g:actionSubmit class="btn" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" />
                    <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
                </div>
            </g:form>
        </div>
    </body>
</html>
