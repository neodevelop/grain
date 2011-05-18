
<%@ page import="com.synergyj.grain.course.Course" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="wb" />
        <title><g:message code="course.create" default="Create Course" /></title>
        <parameter name="pageHeader" value="${g.message(code: 'course.create', default: 'Create Course')}"/>
        <link rel="stylesheet" type="text/css" href="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.css"/>
        <jqui:resources plugin="jquery-ui" themeCss="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.12/themes/overcast/jquery-ui.css" />
        <script type="text/javascript" src="http://akzhan.github.com/jwysiwyg/jquery.wysiwyg.js"></script>
        <g:javascript>
          $(function(){
            $('textarea').wysiwyg();
            $("div.nav a").button();
          });
        </g:javascript>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="course.list" default="Course List" /></g:link></span>
        </div>
        <br/>
        <div id="content">

			      <g:render template="/common/errors" model="[instance:courseInstance]"/>

            <g:form action="save" method="post" name="courseForm" onsubmit="return validateForm(this);">
                <g:render template="courseForm" />
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>

        </div>
    </body>
</html>
