
<%@ page import="com.synergyj.grain.course.ModuleTopic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="moduleTopic.create" default="Create ModuleTopic" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="moduleTopic.list" default="ModuleTopic List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="moduleTopic.create" default="Create ModuleTopic" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${moduleTopicInstance}">
            <div class="errors">
                <g:renderErrors bean="${moduleTopicInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
