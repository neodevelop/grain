<div id="newInstructor" class="modal hide">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Add instructor to this course</h3>
  </div>
  <div class="modal-body">
  <ul id="selectInstructors">
    <g:each in="${instructors}" var="instructor">
      <li id="instructor${instructor.id}">
        <g:remoteLink controller="scheduledCourse" action="addInstructor" id="${scheduledCourseInstance.id}"
                      params="[instructorId:instructor.id]" onSuccess="addToInstructors(${instructor.id})"
                      onComplete="restoreInstructorButton()">
          ${instructor}
      </g:remoteLink>
      </li>
    </g:each>
  </ul>
  </div>
  <div class="modal-footer">
    <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  </div>
</div>