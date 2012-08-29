<div class="control-group">
  <label for="title"><g:message code="content.title" default="Title"/>:</label>
  <g:textField name="title" maxlength="200" value="${contentInstance.title}"/>
</div>

<div class="control-group ${hasErrors(bean: contentInstance, field: 'body', 'errors')}">
  <label for="body"><g:message code="content.body" default="Body"/>:</label>
  <g:textArea name="body" value="" class="wysiwyg full">${contentInstance?.body}</g:textArea>
</div>

<div class="control-group ${hasErrors(bean: contentInstance, field: 'language', 'errors')}">
  <label for="locale"><g:message code="content.locale" default="Locale"/>:</label>
  <g:localeSelect name="locale" value=""/>
</div>

<div class="control-group ${hasErrors(bean: contentInstance, field: 'key', 'errors')}">
  <label for="key"><g:message code="content.key" default="Key"/>:</label>
  <g:textField name="key" maxlength="200" value="${fieldValue(bean: contentInstance, field: 'key')}"/>
</div>

<div class="control-group ${hasErrors(bean: contentInstance, field: 'author', 'errors')}">
  <label for="author"><g:message code="content.author" default="Author"/>:</label>
  <g:select name="author.id" from="${com.synergyj.grain.auth.User.list()}" optionKey="id" value="${contentInstance?.author?.id}" noSelection="['null': '']"/>
</div>

<div class="control-group ${hasErrors(bean: contentInstance, field: 'type', 'errors')}">
  <label for="type"><g:message code="content.type" default="Type"/>:</label>
  <g:select name="type" from="${com.synergyj.grain.content.ContentType?.values()}" value="${contentInstance?.type}"/>
</div>

