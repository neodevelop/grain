
<%@ page import="com.synergyj.grain.course.ModuleTopic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="wb" />
        <title><g:message code="moduleTopic.list" default="ModuleTopic List" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'moduleTopic.list', default: 'Module Topic List')}"/>
        <script type="text/javascript" language="javascript" src="${createLinkTo(dir:'js',file:'tables.js')}"></script>
        <script language="javascript">
          $(function(){
            $("div.list table").styleTable();
          });
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="moduleTopic.new" default="New ModuleTopic" /></g:link></span>
        </div>
        <br/>
        <div class="body">
            <div class="list">
                <table cellpadding="5" cellspacing="0" border="0" width="100%">
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="moduleTopic.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="moduleTopic.name" />
                        
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
                        
                            <td>${fieldValue(bean: moduleTopicInstance, field: "contentType")}</td>
                        
                            <td><g:formatDate date="${moduleTopicInstance.lastUpdated}" format="dd-MM-yy hh:mm" /></td>
                        
                            <td><g:formatDate date="${moduleTopicInstance.dateCreated}" format="dd-MM-yy hh:mm" /></td>
                        
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
