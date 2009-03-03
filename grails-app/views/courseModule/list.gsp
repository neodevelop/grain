
<%@ page import="com.synergyj.grain.domain.CourseModule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>CourseModule List</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create">New CourseModule</g:link></span>
        </div>
        <div class="body">
            <h1>CourseModule List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="name" title="Name" />
                        
                   	        <g:sortableColumn property="content" title="Content" />
                        
                   	        <g:sortableColumn property="lastUpdated" title="Last Updated" />
                        
                   	        <g:sortableColumn property="dateCreated" title="Date Created" />
                        
                   	        <th>Course</th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${courseModuleInstanceList}" status="i" var="courseModuleInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${courseModuleInstance.id}">${fieldValue(bean:courseModuleInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:courseModuleInstance, field:'name')}</td>
                        
                            <td>${fieldValue(bean:courseModuleInstance, field:'content')}</td>
                        
                            <td>${fieldValue(bean:courseModuleInstance, field:'lastUpdated')}</td>
                        
                            <td>${fieldValue(bean:courseModuleInstance, field:'dateCreated')}</td>
                        
                            <td>${fieldValue(bean:courseModuleInstance, field:'course')}</td>
                        
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
