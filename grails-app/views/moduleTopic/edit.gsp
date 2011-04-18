
<%@ page import="com.synergyj.grain.course.ModuleTopic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="moduleTopic.edit" default="Edit ModuleTopic" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="moduleTopic.list" default="ModuleTopic List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="moduleTopic.new" default="New ModuleTopic" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="moduleTopic.edit" default="Edit ModuleTopic" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${moduleTopicInstance}">
            <div class="errors">
                <g:renderErrors bean="${moduleTopicInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${moduleTopicInstance?.id}" />
                <g:hiddenField name="version" value="${moduleTopicInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="moduleTopic.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleTopicInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="100" value="${fieldValue(bean: moduleTopicInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content"><g:message code="moduleTopic.content" default="Content" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleTopicInstance, field: 'content', 'errors')}">
                                    <g:textField name="content" value="${fieldValue(bean: moduleTopicInstance, field: 'content')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contentType"><g:message code="moduleTopic.contentType" default="Content Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleTopicInstance, field: 'contentType', 'errors')}">
                                    <g:select name="contentType" from="${com.synergyj.grain.content.ContentType?.values()}" value="${moduleTopicInstance?.contentType}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="module"><g:message code="moduleTopic.module" default="Module" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleTopicInstance, field: 'module', 'errors')}">
                                    <g:select name="module.id" from="${com.synergyj.grain.course.CourseModule.list()}" optionKey="id" value="${moduleTopicInstance?.module?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="parent"><g:message code="moduleTopic.parent" default="Parent" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleTopicInstance, field: 'parent', 'errors')}">
                                    <g:select name="parent.id" from="${com.synergyj.grain.course.ModuleTopic.list()}" optionKey="id" value="${moduleTopicInstance?.parent?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="order"><g:message code="moduleTopic.order" default="Order" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleTopicInstance, field: 'order', 'errors')}">
                                    <g:textField name="order" value="${fieldValue(bean: moduleTopicInstance, field: 'order')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="topics"><g:message code="moduleTopic.topics" default="Topics" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: moduleTopicInstance, field: 'topics', 'errors')}">
                                    
<ul>
<g:each in="${moduleTopicInstance?.topics}" var="moduleTopicInstance">
    <li><g:link controller="moduleTopic" action="show" id="${moduleTopicInstance.id}">${moduleTopicInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="moduleTopic" params="['moduleTopic.id': moduleTopicInstance?.id]" action="create"><g:message code="moduleTopic.new" default="New ModuleTopic" /></g:link>


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
