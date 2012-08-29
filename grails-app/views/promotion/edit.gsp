<%@ page import="com.synergyj.grain.course.Promotion" %>
<html>
<head>
  
  <meta name="layout" content="mainContent" />
  <title><g:message code="promotion.edit" default="Edit Promotion" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'promotion.edit', default: 'Edit Promotion')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home" /></a>
  <g:link class="btn" action="list"><g:message code="promotion.list" default="Promotion List" /></g:link>
  <g:link class="create" action="create"><g:message code="promotion.new" default="New Promotion" /></g:link>
</div>
<br/>
<div class="body">
  <g:hasErrors bean="${promotionInstance}">
    <div class="errors">
      <g:renderErrors bean="${promotionInstance}" as="list" />
    </div>
  </g:hasErrors>
  <g:form method="post" >
    <g:hiddenField name="id" value="${promotionInstance?.id}" />
    <g:hiddenField name="version" value="${promotionInstance?.version}" />
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="promotionKey"><g:message code="promotion.promotionKey" default="Promotion Key" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: promotionInstance, field: 'promotionKey', 'errors')}">
            <g:textField name="promotionKey" value="${fieldValue(bean: promotionInstance, field: 'promotionKey')}" />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="description"><g:message code="promotion.description" default="Description" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: promotionInstance, field: 'description', 'errors')}">
            <g:textField name="description" value="${fieldValue(bean: promotionInstance, field: 'description')}" />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="discount"><g:message code="promotion.discount" default="Discount" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: promotionInstance, field: 'discount', 'errors')}">
            <g:textField name="discount" value="${fieldValue(bean: promotionInstance, field: 'discount')}" />

          </td>
        </tr>

        <tr class="prop">
          <td valign="top" class="name">
            <label for="kindPromotion"><g:message code="promotion.kindPromotion" default="Kind Promotion" />:</label>
          </td>
          <td valign="top" class="value ${hasErrors(bean: promotionInstance, field: 'kindPromotion', 'errors')}">
            <g:select name="kindPromotion" from="${com.synergyj.grain.course.KindPromotion?.values()}" value="${promotionInstance?.kindPromotion}"  />

          </td>
        </tr>

        </tbody>
      </table>
    </div>
    <div class="form-actions">
      <g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'update', 'default': 'Update')}" />
      <g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" />
    </div>
  </g:form>
</div>
</body>
</html>
