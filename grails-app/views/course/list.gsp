
<%@ page import="com.synergyj.grain.course.Course" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="course.list" default="Course List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="course.new" default="New Course" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="course.list" default="Course List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="course.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="course.name" />
                        
                   	    <th><g:message code="course.contentType" default="Content Type" /></th>
                   	    
                   	    <g:sortableColumn property="lastUpdated" title="Last Updated" titleKey="course.lastUpdated" />
                        
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="course.dateCreated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${courseInstanceList}" status="i" var="courseInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${courseInstance.id}">${fieldValue(bean: courseInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: courseInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: courseInstance, field: "contentType")}</td>
                        
                            <td><g:formatDate date="${courseInstance.lastUpdated}" format="dd-MM-yy hh:mm" /></td>
                        
                            <td><g:formatDate date="${courseInstance.dateCreated}" format="dd-MM-yy hh:mm" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${courseInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
