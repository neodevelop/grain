<div id="newSessionCourse" class="modal hide">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Datos de sesión de curso</h3>
  </div>
  <div class="modal-body">
  <g:formRemote
      name="addSessionToScheduledCourse"
      url="[controller:'scheduledCourse',action:'newSessionToCourse']"
      onSuccess="reacting(data)"
      onComplete="restoreLink()" class="form-horizontal">
    <fieldset>
      <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
      <g:hiddenField name="courseSessionId" value="0"/>
      <div class="control-group">
        <label class="control-label">Fecha de la Sesión:</label>
        <div class="controls"><g:textField name="sessionStartTime" /></div>
      </div>
      <div class="control-group">
        <label class="control-label">Hora de inicio:</label>
        <div class="controls"><g:textField name="sessionHourStartTime" /></div>
      </div>
      <div class="control-group">
        <label class="control-label">Duración(hrs.):</label>
        <div class="controls"><g:select from="${2..9}" name="duration" value="9"  class="span1"/></div>
      </div>
    </fieldset>
  </g:formRemote>
  </div>
  <div class="modal-footer">
    <a href="#" id="addSession" class="btn btn-primary">Send session info</a>
    <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  </div>
</div>