<%@ page import="com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="wb" />
  <title><g:message code="studentsGroup.show" default="Students Group" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'studentsGroup.show', default: 'Students Group')}"/>
  <script language="JavaScript" src="${createLinkTo(dir:'themes/wb/js/studentsGroup',file:'show.js')}"></script>
</head>
<body>
<div class="content">
  <h3>${studentsGroup.key}</h3>

  <h4>Usuarios en el grupo</h4>
  <table id="studentsInGroup">
    <thead>
      <tr>
        <th><g:message code="login.username"/></th>
        <th>&nbsp;</th>
      </tr>
    </thead>
    <tbody>
      <g:each in="${studentsInGroup}" var="student">
      <tr id="student${student.id}">
        <td>${student?.email}</td>
        <td>
          <g:remoteLink controller="studentsGroup" action="removeStudent" id="${student.id}" params="[studentsGroupId:studentsGroup.id]" onSuccess="removeStudentFromGroup(${student.id})">
            <g:message code="studentsGroup.remove" />
          </g:remoteLink>
        </td>
      </tr>
      </g:each>
    </tbody>
  </table>

  <h4>Usuarios registrados al curso</h4>
  <table id="studentsNoGroup">
    <thead>
      <tr>
        <th><g:message code="login.username"/></th>
        <th>&nbsp;</th>
      </tr>
    </thead>
    <tbody>
      <g:each in="${studentsNoGroup}" var="student">
      <tr id="student${student.id}">
        <td>${student?.email}</td>
        <td>
          <g:remoteLink controller="studentsGroup" action="addStudent" id="${student.id}" params="[studentsGroupId:studentsGroup.id]" onSuccess="addStudentToGroup(${student.id})">
            <g:message code="studentsGroup.add" />
          </g:remoteLink>
        </td>
      </tr>
      </g:each>
    </tbody>
  </table>
</div>
</body>
</html>
