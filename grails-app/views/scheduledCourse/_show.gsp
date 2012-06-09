<div id="courseInfo">
  <h2>${scheduledCourse.course.name}<h2/>
  <p>Inicia: <g:formatDate date="${scheduledCourse.beginDate}" format="EEEE dd 'de' MMMM 'del' yyyy"/></p>
</div>
<dl class="dl-horizontal">
  <dt>Duración:</dt>
  <dd>${scheduledCourse.durationInHours} horas</dd>
  <dt>Dirección:</dt>
  <dd>${scheduledCourse.fullAddress}</dd>
  <dt>Inversión:</dd>
  <dd>${scheduledCourse.costByCourse}</dt>
</dl>
<hr>
<div class="row">
  <div class="span3">
    <h3>Sesiones</h3>
    <ul>
      <g:each in="${scheduledCourse.courseSessions.sort()}" var="courseSession">
        <li>${courseSession}</li>
      </g:each>
    </ul>
  </div>
  <div class="span3">
    <h3>Impartido por</h3>
    <ul>
      <g:each in="${scheduledCourse.instructors}" var="instructor">
        <li>${instructor}</li>
      </g:each>
    </ul>
  </div>
</div>