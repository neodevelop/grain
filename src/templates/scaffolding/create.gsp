<% import org.codehaus.groovy.grails.orm.hibernate.support.ClosureEventTriggeringInterceptor as Events %>
<%=packageName%>
<html>
    <head>
        
        <meta name="layout" content="main" />
        <title><g:message code="${domainClass.propertyName}.create" default="Create ${className}" /></title>
    </head>
    <body>
        <div class="nav">
            <a class="btn" href="\${resource(dir: '')}"><g:message code="home" default="Home" /></a>
            <g:link class="btn" action="list"><g:message code="${domainClass.propertyName}.list" default="${className} List" /></g:link>
        </div>
        <div class="body">
            <h1><g:message code="${domainClass.propertyName}.create" default="Create ${className}" /></h1>
            <g:if test="\${flash.message}">
            <div class="message"><g:message code="\${flash.message}" args="\${flash.args}" default="\${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="\${${propertyName}}">
            <div class="errors">
                <g:renderErrors bean="\${${propertyName}}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" <%= multiPart ? " enctype=\"multipart/form-data\"" : "" %>>
                <div class="dialog">
                    <table>
                        <tbody>
                        <%  excludedProps = ["version",
                                             "id",
                                             Events.ONLOAD_EVENT,
                                             Events.BEFORE_INSERT_EVENT,
                                             Events.BEFORE_UPDATE_EVENT,
                                             Events.BEFORE_DELETE_EVENT]
                            props = domainClass.properties.findAll { !excludedProps.contains(it.name) }
                            Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                            props.each { p ->
                                if (!Collection.class.isAssignableFrom(p.type)) {
                                    cp = domainClass.constrainedProperties[p.name]
                                    display = (cp ? cp.display : true)
                                    if (display) { %>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="${p.name}"><g:message code="${domainClass.propertyName}.${p.name}" default="${p.naturalName}" />:</label>
                                </td>
                                <td valign="top" class="value \${hasErrors(bean: ${propertyName}, field: '${p.name}', 'errors')}">
                                    ${renderEditor(p)}
                                </td>
                            </tr>
                        <%  }   }   } %>
                        </tbody>
                    </table>
                </div>
                <div class="form-actions">
                    <g:submitButton name="create" class="btn btn-primary" value="\${message(code: 'create', 'default': 'Create')}" />
                </div>
            </g:form>
        </div>
    </body>
</html>
