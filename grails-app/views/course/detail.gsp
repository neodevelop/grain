<%@ page import="com.synergyj.grain.domain.Course" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="course.detail" default="Course details..." /></title>
    </head>
    <body>
		<div id="editCourseForm">
		</div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${courseInstance?.id}" />

                <div class="dialog">
					<h2>
						${courseInstance?.courseType}
					</h2>
					<h3>
						${courseInstance?.name}
					</h3>
					<h3>
						<g:message code="course.status" default="Status" />: ${courseInstance?.status}
					</h3>
					<div class="description">
						<p>
							${courseInstance?.content}
						</p>
					</div>
					
					<div class="description">
						<b><g:message code="course.overview" default="Overview" /></b>${courseInstance?.overview}
					</div>
					
					<div class="description">
						<b>
							<g:message code="course.audience" default="Audience" />
						</b>
						${courseInstance?.audience}
					</div>
					
					<div class="description">
						<b>
							<g:message code="course.prerequisites" default="Prerequisites" />
						</b>
						${courseInstance?.prerequisites}
					</div>
					
					<div class="description">
						<b>
							<g:message code="course.goal" default="Goal" />
						</b>
						${courseInstance?.goal}
					</div>
					
					<div class="description">
						<b>
							<g:message code="course.method" default="Method" />
						</b>
						${courseInstance?.method}
					</div>
					
					<div class="description">
						<b>
							<g:message code="course.format" default="Format" />
						</b>
						${courseInstance?.format}
					</div>
					
					<g:if test="${courseInstance?.modules?.size() > 0}">
						<div class="description">
							<h4>
								<g:message code="course.modules" default="Modules" />
							</h4>
							<ul>
		                    <g:each in="${courseInstance?.modules}" var="courseModuleInstance">
		                        <li><g:link controller="courseModule" action="show" id="${courseModuleInstance.id}">${courseModuleInstance.encodeAsHTML()}</g:link></li>
		                    </g:each>
		                    </ul>
						</div>
					</g:if>
					
					
					
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>

			<g:formRemote name="name" url="[action:'editCourse', id:courseInstance.id]" update="editCourseForm">
				<g:submitButton name="addMirror" value="Add Mirror" />
			</g:formRemote>
        </div>
    </body>
</html>
