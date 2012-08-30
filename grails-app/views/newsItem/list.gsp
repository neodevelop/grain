
<%@ page import="com.synergyj.grain.content.NewsItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>NewsItem List</title>
    </head>
    <body>
        <div class="nav">
            <a class="btn" href="${resource(dir:'')}">Home</a>
            <g:link class="btn btn-primary" action="create">New NewsItem</g:link>
        </div>
        <div class="body">
            <h1>NewsItem List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="btn">
                <table>
                    <thead>
                        <tr>
                        
                   	        <g:sortableColumn property="id" title="Id" />
                        
                   	        <g:sortableColumn property="title" title="Title" />
                        
                   	        <g:sortableColumn property="body" title="Body" />
                        
                   	        <th>Author</th>
                   	    
                   	        <g:sortableColumn property="dateCreated" title="Date Created" />
                        
                   	        <g:sortableColumn property="lastUpdated" title="Last Updated" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${newsItemInstanceList}" status="i" var="newsItemInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${newsItemInstance.id}">${fieldValue(bean:newsItemInstance, field:'id')}</g:link></td>
                        
                            <td>${fieldValue(bean:newsItemInstance, field:'title')}</td>
                        
                            <td>${fieldValue(bean:newsItemInstance, field:'body')}</td>
                        
                            <td>${fieldValue(bean:newsItemInstance, field:'author')}</td>
                        
                            <td>${fieldValue(bean:newsItemInstance, field:'dateCreated')}</td>
                        
                            <td>${fieldValue(bean:newsItemInstance, field:'lastUpdated')}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${newsItemInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
