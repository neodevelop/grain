
<%@ page import="com.synergyj.grain.domain.CourseModule" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Create CourseModule</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list">CourseModule List</g:link></span>
        </div>
        <div class="body">
            <h1>Create CourseModule</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${courseModuleInstance}">
            <div class="errors">
                <g:renderErrors bean="${courseModuleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:courseModuleInstance,field:'name','errors')}">
                                    <input type="text" maxlength="100" id="name" name="name" value="${fieldValue(bean:courseModuleInstance,field:'name')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="content">Content:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:courseModuleInstance,field:'content','errors')}">
                                    <input type="text" id="content" name="content" value="${fieldValue(bean:courseModuleInstance,field:'content')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="course">Course:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:courseModuleInstance,field:'course','errors')}">
                                    <g:select optionKey="id" from="${com.synergyj.grain.domain.Course.list()}" name="course.id" value="${courseModuleInstance?.course?.id}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="order">Order:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:courseModuleInstance,field:'order','errors')}">
                                    <input type="text" id="order" name="order" value="${fieldValue(bean:courseModuleInstance,field:'order')}" />
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><input class="save" type="submit" value="Create" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
