
<%@ page import="com.synergyj.grain.course.ModuleTopic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="moduleTopic.list" default="ModuleTopic List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="moduleTopic.new" default="New ModuleTopic" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="moduleTopic.list" default="ModuleTopic List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="moduleTopic.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="moduleTopic.name" />
                        
                   	    <g:sortableColumn property="content" title="Content" titleKey="moduleTopic.content" />
                        
                   	    <th><g:message code="moduleTopic.contentType" default="Content Type" /></th>
                   	    
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="moduleTopic.lastUpdated" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="moduleTopic.dateCreated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${moduleTopicInstanceList}" status="i" var="moduleTopicInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${moduleTopicInstance.id}">${fieldValue(bean: moduleTopicInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: moduleTopicInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: moduleTopicInstance, field: "content")}</td>
                        
                            <td>${fieldValue(bean: moduleTopicInstance, field: "contentType")}</td>
                        
                            <td><g:formatDate date="${moduleTopicInstance.lastUpdated}" /></td>
                        
                            <td><g:formatDate date="${moduleTopicInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${moduleTopicInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
