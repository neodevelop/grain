
<%@ page import="com.synergyj.grain.course.Course" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="wb" />
        <title><g:message code="course.list" default="Course List" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'course.list', default: 'Course List')}"/>
        <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'tables.js')}"></script>
        <script language="javascript">
          $(function(){
            $("div.list table").styleTable();
          });
        </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButto  n"><g:link class="create" action="create"><g:message code="course.new" default="New Course" /></g:link></span>
        </div>
        <br/>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table cellpadding="5" cellspacing="0" border="0" width="100%">
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="course.name" />
                        
                   	    <th><g:message code="course.contentType" default="Content Type" /></th>
                   	    
                   	    <g:sortableColumn property="courseKey" title="Course Key" titleKey="course.courseKey" />
                        
                   	    <g:sortableColumn property="status" title="Course status" titleKey="course.status" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${courseInstanceList}" status="i" var="courseInstance">
                        <tr>
                        
                            <td width="40%"><g:link action="show" id="${courseInstance.id}">${fieldValue(bean: courseInstance, field: "name")}</g:link></td>
                        
                            <td>${fieldValue(bean: courseInstance, field: "contentType")}</td>
                        
                            <td>${fieldValue(bean: courseInstance, field: "courseKey")}</td>
                        
                            <td>${fieldValue(bean: courseInstance, field: "status")}</td>
                        
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
