
<%@ page import="com.synergyj.grain.course.CourseModule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="courseModule.list" default="CourseModule List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="courseModule.new" default="New CourseModule" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="courseModule.list" default="CourseModule List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="courseModule.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="courseModule.name" />
                        
                   	    <g:sortableColumn property="content" title="Content" titleKey="courseModule.content" />
                        
                   	    <th><g:message code="courseModule.contentType" default="Content Type" /></th>
                   	    
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="courseModule.lastUpdated" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="courseModule.dateCreated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${courseModuleInstanceList}" status="i" var="courseModuleInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${courseModuleInstance.id}">${fieldValue(bean: courseModuleInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: courseModuleInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: courseModuleInstance, field: "content")}</td>
                        
                            <td>${fieldValue(bean: courseModuleInstance, field: "contentType")}</td>
                        
                            <td><g:formatDate date="${courseModuleInstance.lastUpdated}" /></td>
                        
                            <td><g:formatDate date="${courseModuleInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${courseModuleInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
