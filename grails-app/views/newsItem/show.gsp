
<%@ page import="com.synergyj.grain.content.NewsItem" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Show NewsItem</title>
    </head>
    <body>
        <div class="nav">
            <a class="home" href="${resource(dir:'')}">Home</a>
            <g:link class="btn" action="list">NewsItem List</g:link>
            <g:link class="create" action="create">New NewsItem</g:link>
        </div>
        <div class="body">
            <h1>Show NewsItem</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>

                    
                        <tr class="prop">
                            <td valign="top" class="name">Id:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:newsItemInstance, field:'id')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Title:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:newsItemInstance, field:'title')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Body:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:newsItemInstance, field:'body')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Author:</td>
                            
                            <td valign="top" class="value"><g:link controller="user" action="show" id="${newsItemInstance?.author?.id}">${newsItemInstance?.author?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Comments:</td>
                            
                            <td  valign="top" style="text-align:left;" class="value">
                                <ul>
                                <g:each var="c" in="${newsItemInstance.comments}">
                                    <li><g:link controller="comment" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Date Created:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:newsItemInstance, field:'dateCreated')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Last Updated:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:newsItemInstance, field:'lastUpdated')}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Published Date:</td>
                            
                            <td valign="top" class="value">${fieldValue(bean:newsItemInstance, field:'publishedDate')}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="form-actions">
                <g:form>
                    <input type="hidden" name="id" value="${newsItemInstance?.id}" />
                    <g:actionSubmit class="btn" value="Edit" />
                    <g:actionSubmit class="btn btn-danger" onclick="return confirm('Are you sure?');" value="Delete" />
                </g:form>
            </div>
        </div>
    </body>
</html>
