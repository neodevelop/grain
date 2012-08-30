
<%@ page import="com.synergyj.grain.course.CourseModule" %>
<html>
    <head>
        
        <meta name="layout" content="mainContent" />
        <title><g:message code="courseModule.list" default="CourseModule List" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'courseModule.list', default: 'Course Module List')}"/>
        <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'tables.js')}"></script>
        <script language="javascript">
          $(function(){
            $("div.list table").styleTable();
          });
        </script>
    </head>
    <body>
        <div class="nav">
            <g:link class="btn btn-primary" action="create"><g:message code="courseModule.new" default="New CourseModule" /></g:link>
        </div>
        <br/>
        <div class="body">

            <div class="btn">
                <table cellpadding="5" cellspacing="0" border="0" width="100%">
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="courseModule.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="courseModule.name" />
                        
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
                        
                            <td>${fieldValue(bean: courseModuleInstance, field: "contentType")}</td>
                        
                            <td><g:formatDate date="${courseModuleInstance.lastUpdated}" format="dd-MM-yy hh:mm" /></td>
                        
                            <td><g:formatDate date="${courseModuleInstance.dateCreated}" format="dd-MM-yy hh:mm" /></td>
                        
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
