<script type="text/javascript" src="http://www.mailermailer.com/js/jquery/jquery.kolorpicker.js"></script>
<link rel="stylesheet" href="http://www.mailermailer.com/style/kolorpicker.css" type="text/css" media="screen, tv, projection, print" />

<div class="control-group">
  <label for="name" class="control-label"><g:message code="course.name" default="Name" />:</label>
  <div class="controls">
    <g:textField name="name" class="input-xlarge" value="${fieldValue(bean: courseInstance, field: 'name')}" />
  </div>
</div>

<div class="control-group">
  <label for="courseKey" class="control-label"><g:message code="course.courseKey" default="Course Key" />:</label>
  <div class="controls">
    <g:textField name="courseKey" class="input-xlarge" maxlength="20" value="${fieldValue(bean: courseInstance, field: 'courseKey')}" />
  </div>
</div>

<div class="control-group">
  <label for="urlLandingPage" class="control-label"><g:message code="course.url" default="URL Landing" />:</label>
  <div class="controls">
    <g:textField name="urlLandingPage" class="input-xlarge" maxlength="50" value="${fieldValue(bean: courseInstance, field: 'urlLandingPage')}" />
  </div>
</div>

<div class="control-group">
  <label for="status" class="control-label"><g:message code="course.color" default="Color" />:</label>
  <div class="controls">
    <g:textField name="color" class="input-xlarge kolorPicker" value="${courseInstance?.color}" />
  </div>
</div>

<div class="control-group">
  <label for="status" class="control-label"><g:message code="course.backgroundColor" default="BackgroundColor" />:</label>
  <div class="controls">
    <g:textField name="backgroundColor" class="input-xlarge kolorPicker" value="${courseInstance?.backgroundColor}" />
  </div>
</div>

<div class="control-group">
  <label for="status" class="control-label"><g:message code="course.borderColor" default="BorderColor" />:</label>
  <div class="controls">
    <g:textField name="borderColor" class="kolorPicker input-xlarge" value="${courseInstance?.borderColor}" />
  </div>
</div>

<div class="control-group">
  <label for="status" class="control-label"><g:message code="course.textColor" default="TextColor" />:</label>
  <div class="controls">
    <g:textField name="textColor" value="${courseInstance?.textColor}" class="kolorPicker input-xlarge" />
  </div>
</div>

<div class="control-group">
  <label for="content" class="control-label"><g:message code="course.content" default="Content" />:</label>
  <div class="controls">
    <g:textArea name="content" value="" class="wysiwyg full">${courseInstance?.content}</g:textArea>
  </div>
</div>

<div class="control-group">
  <label for="overview" class="control-label"><g:message code="course.overview" default="Overview" />:</label>
  <div class="controls">
    <g:textArea name="overview" class="wysiwyg full">${courseInstance?.overview}</g:textArea>
  </div>
</div>

<div class="control-group">
  <label for="audience" class="control-label"><g:message code="course.audience" default="Audience" />:</label>
  <div class="controls">
    <g:textArea name="audience" class="wysiwyg full">${courseInstance?.audience}</g:textArea>
  </div>
</div>

<div class="control-group">
  <label for="prerequisites" class="control-label"><g:message code="course.prerequisites" default="Prerequisites" />:</label>
  <div class="controls">
    <g:textArea name="prerequisites" class="wysiwyg full">${courseInstance?.prerequisites}</g:textArea>
  </div>
</div>

<g:if test="${courseInstance?.id}">
  <label class="control-label"><g:message code="course.modules" default="Modules" />:</label>
  <ul>
    <g:each in="${courseInstance?.modules}" var="courseModuleInstance">
      <li><g:link controller="courseModule" action="show" id="${courseModuleInstance.id}">${courseModuleInstance?.encodeAsHTML()}</g:link></li>
    </g:each>
  </ul>
  <g:link controller="courseModule" params="['course.id': courseInstance?.id]" action="create">
    <g:message code="courseModule.new" default="New CourseModule" />
  </g:link>
</g:if>

        

<div class="control-group">
  <label for="goal" class="control-label"><g:message code="course.goal" default="Goal" />:</label>
  <div class="controls">
    <g:textArea name="goal" class="wysiwyg full">${courseInstance?.goal}</g:textArea>
  </div>
</div>

<div class="control-group">
  <label for="method" class="control-label"><g:message code="course.method" default="Method" />:</label>
  <div class="controls">
    <g:textArea name="method" class="wysiwyg full">${courseInstance?.method}</g:textArea>
  </div>
</div>

<div class="control-group">
  <label for="format" class="control-label"><g:message code="course.format" default="Format" />:</label>
  <div class="controls">
    <g:textArea name="format" class="wysiwyg full">${courseInstance?.format}</g:textArea>
  </div>
</div>

<div class="control-group">
  <label for="contentType" class="control-label"><g:message code="course.contentType" default="Content Type" />:</label>
  <div class="controls">
    <g:select name="contentType" from="${com.synergyj.grain.content.ContentType?.values()}" value="${courseInstance?.contentType}"  />
  </div>
</div>

<div class="control-group">
  <label for="courseType" class="control-label"><g:message code="course.courseType" default="Course Type" />:</label>
  <div class="controls">
    <g:select name="courseType" from="${com.synergyj.grain.course.CourseType?.values()}" value="${courseInstance?.courseType}"  />
  </div>
</div>

<div class="control-group">
  <label for="status" class="control-label"><g:message code="course.status" default="Status" />:</label>
  <div class="controls">
    <g:select name="status" from="${com.synergyj.grain.course.Status?.values()}" value="${courseInstance?.status}"  />
  </div>
</div>
