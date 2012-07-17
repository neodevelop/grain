<!doctype html>
<html>
	<head>
		<meta name="layout" content="main"/>
    <r:require module="common"/>
    <r:require module="home"/>
	</head>
	<body>
      <div class="home hero-unit">
        <h1>Bienvenido a tu entrenamiento</h1>
        <p>Es momento de potenciar tu desempeño y atender tu plan de carrera de desarrollador de la mejor manera, para ello, hemos puesto a tu disposición esta aplicación, donde podras administrar los cursos que deseas tomar y planear la adquisicion de los skills necesarios en esta rama tan competida.</p>
        <!--p><a class="btn btn-primary btn-large">Comienza aquí... &raquo;</a></p-->
      </div>
      <div class="page-header">
        <h1>Próximos cursos</h1>
      </div>
      <div class="row">
        <g:each in="${scheduledCourses}" var="scheduledCourse">
        <div class="span4">
          <h2>${scheduledCourse.course.name}</h2>
          <p>
            <dl>
              <dt>Inicia</dt>
              <dd>
                <span class="label label-info">
                  <g:formatDate date="${scheduledCourse.beginDate}" format="EEEE "/>
                </span>&nbsp;
                <g:formatDate date="${scheduledCourse.beginDate}" format="dd / MMMM / yyyy"/>
              </dd>
              <dt>Overview</dt>
              <dd>${scheduledCourse.course.overview}</dd>
              <dt>Duración</dt>
              <dd><span class="badge badge-info">${scheduledCourse.durationInHours}</span> horas</dd>
            </dl>
            <a href="${scheduledCourse.course.urlLandingPage}" class="btn">Más información...</a>
          </p>
        </div>
        </g:each>
      </div>
      
      <div class="page-header">
        <h1>Los profesionales dicen...</h1>
      </div>

      <div id="comments">
      <g:set var="counter" value="${1}"/>
      <g:each in="${comments}" var="comment" status="i">
        <g:if test="${(counter - 1) % 3 == 0}">
          <div class="row">
        </g:if>
            <div class="span4">
              <blockquote>
              <p>${comment.description}</p>
              <small>Anónimo</small>
              </blockquote>
            </div>
        <g:if test="${counter % 3 == 0}">
          </div>
          <g:set var="counter" value="${1}"/>
        </g:if>
        <g:else>
          <g:set var="counter" value="${counter + 1}"/>
        </g:else>
      </g:each>
      <g:if test="${counter % 3 != 0}">
        </div>
      </g:if>

      <div class="row">
        <div class="span4">
          <h2>Cursos</h2>
           <p>En cursos de desarrollo de software estamos convencidos que nuestra experiencia y la práctica del conocimiento será lo que te dará la mayor satisfacción. </p>
          <p><a class="btn" href="#">Explora más.. &raquo;</a></p>
        </div>
        <div class="span4">
          <h2>Comunidad</h2>
           <p>No serás sólo un alumno, cuando asistes a nuestros cursos, te conviertes en parte de la comunidad de desarrolladores que realmente hacen diferencia en su profesión. </p>
          <p><a class="btn" href="#">Conoce más... &raquo;</a></p>
       </div>
        <div class="span4">
          <h2>Inscribete</h2>
          <p>Es gratis! Mantente actualizado, recibe promociones y alístate para ser parte de la comunidad de desarrolladores en constante evolucion.</p>
          <p><a class="btn" href="#">Comienza aquí... &raquo;</a></p>
        </div>
      </div>
      <hr>
	</body>
</html>
