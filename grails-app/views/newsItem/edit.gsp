
<%@ page import="com.synergyj.grain.content.NewsItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Edit NewsItem</title>
    </head>
    <body>
        <div class="nav">
            <a class="btn" href="${resource(dir:'')}">Home</a>
            <g:link class="btn" action="list">NewsItem List</g:link>
            <g:link class="btn btn-primary" action="create">New NewsItem</g:link>
        </div>
        <div class="body">
            <h1>Edit NewsItem</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${newsItemInstance}">
            <div class="errors">
                <g:renderErrors bean="${newsItemInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <input type="hidden" name="id" value="${newsItemInstance?.id}" />
                <input type="hidden" name="version" value="${newsItemInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title">Title:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsItemInstance,field:'title','errors')}">
                                    <input type="text" maxlength="200" id="title" name="title" value="${fieldValue(bean:newsItemInstance,field:'title')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="body">Body:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsItemInstance,field:'body','errors')}">
                                    <textarea rows="5" cols="40" name="body">${fieldValue(bean:newsItemInstance, field:'body')}</textarea>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="author">Author:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsItemInstance,field:'author','errors')}">
                                    <g:select optionKey="id" from="${com.grainapp.auth.User.list()}" name="author.id" value="${newsItemInstance?.author?.id}" noSelection="['null':'']"></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments">Comments:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsItemInstance,field:'comments','errors')}">
                                    <g:select name="comments"
from="${com.grainapp.content.Comment.list()}"
size="5" multiple="yes" optionKey="id"
value="${newsItemInstance?.comments}" />

                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated">Date Created:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsItemInstance,field:'dateCreated','errors')}">
                                    <g:datePicker name="dateCreated" value="${newsItemInstance?.dateCreated}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated">Last Updated:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsItemInstance,field:'lastUpdated','errors')}">
                                    <g:datePicker name="lastUpdated" value="${newsItemInstance?.lastUpdated}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="publishedDate">Published Date:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:newsItemInstance,field:'publishedDate','errors')}">
                                    <g:datePicker name="publishedDate" value="${newsItemInstance?.publishedDate}" ></g:datePicker>
                                </td>
                            </tr> 
                        
                        </tbody>
                    </table>
                </div>
                <div class="form-actions">
                    <g:actionSubmit class="btn btn-primary" value="Update" />
                    <g:actionSubmit class="btn btn-danger" onclick="return confirm('Are you sure?');" value="Delete" />
                </div>
            </g:form>
        </div>
    </body>
</html>
