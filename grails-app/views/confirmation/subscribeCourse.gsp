<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="layout" content="main" />
<title>::: SynergyJ :::</title>
</head>
<body>
	<div class="container">
		<g:if test="${scheduledCourse}">
			<div class="row">
				<div class="colspan12">
					<h1>
						${scheduledCourse.course.name}
					</h1>
					<div class="word-wrap: break-word">
						${scheduledCourse.course.overview}
					</div>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="colspan6">
					<h3>Prerequisitos</h3>
					<div>
						${scheduledCourse.course.prerequisites}
					</div>
					<h3>Dirección del curso</h3>
					${scheduledCourse.fullAddress}
				</div>
				<div class="colspan6">
					<g:hiddenField name="geolocation"
						value="${scheduledCourse?.geolocation}" />
					<g:render template="/common/map"
						model="[refField:'geolocation',width:400,height:200]" />
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="colspan4">
					<div>
						Fecha de inicio: <span class="label label-success"><g:formatDate
								date="${scheduledCourse?.beginDate}" format="dd-MMMM-yyyy" /></span>
					</div>
					<div>
						Costo del Curso: <span class="label label-info"><g:formatNumber
								number="${scheduledCourse?.costByCourse}" locale="es_MX"
								format="\$ ###,##0.00" /></span>
					</div>
				</div>
				<div class="colspan4">
					<h3>Sesiones:</h3>
					<ul>
						<g:each in="${scheduledCourse.courseSessions.sort()}"
							var="courseSessionInstance">
							<li><span> ${courseSessionInstance?.encodeAsHTML()}
							</span> &nbsp;-&nbsp; <span
								id="sessionCourseEndTime${courseSessionInstance.id}"> <g:formatDate
										date="${courseSessionInstance?.sessionEndTime}" format="HH:mm" />
							</span></li>
						</g:each>
					</ul>
				</div>
				<div class="colspan4">
					<h3>Instructores:</h3>
					<g:each in="${scheduledCourse.instructors}" var="instructor">
						<li>
							${instructor}
						</li>
					</g:each>
				</div>
			</div>
			<hr>
			<h3>Inscribete aqui</h3>
			<form id="inscription"  action="${url}/addMeFromConfirmation"  method="post" >
				<input type="hidden" value="${id}" name="scheduledCourseId"
					id="scheduledCourseId" /> <input type="text" tabindex="1"
					class="text" value="Email" name="email" id="email" />
				<r:img id="validEmail" uri="/images/validYes.png" width="16" />
				<r:img id="noValidEmail" uri="/images/validNo.png" width="16" />
				<input type="submit" tabindex="4" class="btn btn-large btn-primary"
					value="Inscribete ya!!!" />
			</form>
			<div style="display: none;" id="messageInfo">
				<span id="loader"></span>
			</div>
		</g:if>
		<g:else>
			<h1>No existe el curso solicitado</h1>
		</g:else>
	</div>
	<script language="JavaScript"
		src="${resource(dir:'js/confirmation',file:'script.js')}"></script>
</body>
</html>