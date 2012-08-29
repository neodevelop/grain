<%@ page import="com.synergyj.grain.course.Course" %>
<html>
	<head>
		
		<meta name="layout" content="main" />
		<title><g:message code="setup.index" default="Setup Wizard" /></title>
	</head>
	<body>
		<div class="body">
			<g:if test="${noUsers}">
				<g:message code="user.nousers" default="No users found" />
			</g:if>
			<g:else>
				<g:render template="/user/users" />
			</g:else>
		</div>
	</body>
</html>

http://tinyurl.com/nf2gb7