<%@ page import="com.synergyj.grain.ui.LinkParam" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="linkParam.list" default="LinkParam List"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'linkParam.list', default: 'LinkParam List')}"/>
</head>
<body>
<div class="nav">
  <a class="home" href="${resource(dir: '')}"><g:message code="home" default="Home"/></a>
  <g:link class="create" action="create"><g:message code="linkParam.new" default="New LinkParam"/></g:link>
</div>
<div class="body">
  <g:if test="${flash.message}">
    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/></div>
  </g:if>
  <div class="btn">
    <table>
      <thead>
      <tr>

        <g:sortableColumn property="id" title="Id" titleKey="linkParam.id"/>

        <g:sortableColumn property="name" title="Name" titleKey="linkParam.name"/>

        <g:sortableColumn property="value" title="Value" titleKey="linkParam.value"/>

        <th><g:message code="linkParam.menuItem" default="Menu Item"/></th>

      </tr>
      </thead>
      <tbody>
      <g:each in="${linkParamInstanceList}" status="i" var="linkParamInstance">
        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

          <td><g:link action="show" id="${linkParamInstance.id}">${fieldValue(bean: linkParamInstance, field: "id")}</g:link></td>

          <td>${fieldValue(bean: linkParamInstance, field: "name")}</td>

          <td>${fieldValue(bean: linkParamInstance, field: "value")}</td>

          <td>${fieldValue(bean: linkParamInstance, field: "menuItem")}</td>

        </tr>
      </g:each>
      </tbody>
    </table>
  </div>
  <div class="paginateButtons">
    <g:paginate total="${linkParamInstanceTotal}"/>
  </div>
</div>
</body>
</html>
