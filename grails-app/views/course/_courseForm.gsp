<jv:generateValidation domain="course" form="courseForm" display="list" container="errors"/>
<resource:richTextEditor type="full"/>
<div class="dialog">
    <table>
        <tbody>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="name"><g:message code="course.name" default="Name" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'name', 'errors')}">
                    <g:textField name="name" maxlength="100" value="${fieldValue(bean: courseInstance, field: 'name')}" />
                </td>
            </tr>

			<tr class="prop">
                <td valign="top" class="name">
                    <label for="courseKey"><g:message code="course.courseKey" default="Course Key" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'courseKey', 'errors')}">
                    <g:textField name="courseKey" maxlength="20" value="${fieldValue(bean: courseInstance, field: 'courseKey')}" />
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="content"><g:message code="course.content" default="Content" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'content', 'errors')}">
					<richui:richTextEditor name="content" value="${courseInstance?.content}"/>
                </td>
            </tr>

			<tr class="prop">
                <td valign="top" class="name">
                    <label for="overview"><g:message code="course.overview" default="Overview" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'overview', 'errors')}">
					<richui:richTextEditor name="overview" value="${courseInstance?.overview}"/>
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="audience"><g:message code="course.audience" default="Audience" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'audience', 'errors')}">
					<richui:richTextEditor name="audience" value="${courseInstance?.audience}"/>
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="prerequisites"><g:message code="course.prerequisites" default="Prerequisites" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'prerequisites', 'errors')}">
					<richui:richTextEditor name="prerequisites" value="${courseInstance?.prerequisites}"/>
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="goal"><g:message code="course.goal" default="Goal" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'goal', 'errors')}">
					<richui:richTextEditor name="goal" value="${courseInstance?.goal}"/>
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="method"><g:message code="course.method" default="Method" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'method', 'errors')}">
					<richui:richTextEditor name="method" value="${courseInstance?.method}"/>
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="format"><g:message code="course.format" default="Format" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'format', 'errors')}">
					<richui:richTextEditor name="format" value="${courseInstance?.format}"/>
                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="contentType"><g:message code="course.contentType" default="Content Type" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'contentType', 'errors')}">
                    <g:select name="contentType" from="${com.synergyj.grain.content.ContentType?.values()}" value="${courseInstance?.contentType}"  />

                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="courseType"><g:message code="course.courseType" default="Course Type" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'courseType', 'errors')}">
                    <g:select name="courseType" from="${com.synergyj.grain.domain.CourseType?.values()}" value="${courseInstance?.courseType}"  />

                </td>
            </tr>
        
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="status"><g:message code="course.status" default="Status" />:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'status', 'errors')}">
                    <g:select name="status" from="${com.synergyj.grain.domain.Status?.values()}" value="${courseInstance?.status}"  />

                </td>
            </tr>

			<g:if test="${courseInstance?.id}">
				<tr class="prop">
	                <td valign="top" class="name">
	                    <label for="modules"><g:message code="course.modules" default="Modules" />:</label>
	                </td>
	                <td valign="top" class="value ${hasErrors(bean: courseInstance, field: 'modules', 'errors')}">

	<ul>
	<g:each in="${courseInstance?.modules}" var="courseModuleInstance">
	<li><g:link controller="courseModule" action="show" id="${courseModuleInstance.id}">${courseModuleInstance?.encodeAsHTML()}</g:link></li>
	</g:each>
	</ul>
	<g:link controller="courseModule" params="['course.id': courseInstance?.id]" action="create"><g:message code="courseModule.new" default="New CourseModule" /></g:link>


	                </td>
	            </tr>
			</g:if>

			
        
        </tbody>
    </table>
</div>