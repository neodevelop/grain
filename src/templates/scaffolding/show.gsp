<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<html>
    <head>
        
        <meta name="layout" content="main" />
        <title><g:message code="${domainClass.propertyName}.show" default="Show ${className}" /></title>
    </head>
    <body>
        <div class="nav">
            <a class="btn" href="\${resource(dir: '')}"><g:message code="home" default="Home" /></a>
            <g:link class="btn" action="list"><g:message code="${domainClass.propertyName}.list" default="${className} List" /></g:link>
            <g:link class="create" action="create"><g:message code="${domainClass.propertyName}.new" default="New ${className}" /></g:link>
        </div>
        <div class="body">
            <h1><g:message code="${domainClass.propertyName}.show" default="Show ${className}" /></h1>
            <g:if test="\${flash.message}">
            <div class="message"><g:message code="\${flash.message}" args="\${flash.args}" default="\${flash.defaultMessage}" /></div>
            </g:if>homehome
            <g:form>
                <g:hiddenField name="id" value="\${${propertyName}?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        <%  excludedProps = ["version",
                                             Events.ONLOAD_EVENT,
                                             Events.BEFORE_INSERT_EVENT,
                                             Events.BEFORE_UPDATE_EVENT,
                                             Events.BEFORE_DELETE_EVENT]
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.each { p -> %>
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="${domainClass.propertyName}.${p.name}" default="${p.naturalName}" />:</td>
                                <%  if (p.isEnum()) { %>
                                <td valign="top" class="value">\${${propertyName}?.${p.name}?.encodeAsHTML()}</td>
                                <%  } else if (p.oneToMany || p.manyToMany) { %>
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="\${${propertyName}?.${p.name}}" var="${p.referencedDomainClass?.propertyName}Instance">
                                        <li><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.referencedDomainClass?.propertyName}Instance.id}">\${${p.referencedDomainClass?.propertyName}Instance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                <%  } else if (p.manyToOne || p.oneToOne) { %>
                                <td valign="top" class="value"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></td>
                                <%  } else if (p.type == Boolean.class || p.type == boolean.class) { %>
                                <td valign="top" class="value"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></td>
                                <%  } else if (p.type == Date.class || p.type == java.sql.Date.class || p.type == java.sql.Time.class || p.type == Calendar.class) { %>
                                <td valign="top" class="value"><g:formatDate date="\${${propertyName}?.${p.name}}" /></td>
                                <%  } else if (BigDecimal.class.isAssignableFrom(p.type)) { %>
                                <td valign="top" class="value"><g:formatNumber number="\${${propertyName}?.${p.name}}" /></td>
                                <%  } else { %>
                                <td valign="top" class="value">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                                <%  } %>
                            </tr>
                            <%  } %>
                        </tbody>
                    </table>
                </div>
                <div class="form-actions">
                    <g:actionSubmit class="btn" action="edit" value="\${message(code: 'edit', 'default': 'Edit')}" />
                    <g:actionSubmit class="btn btn-danger" action="delete" value="\${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('\${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
                </div>
            </g:form>
        </div>
    </body>
</html>
