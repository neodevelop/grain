<div id="addStudentsToCourse" class="modal hide">
  <g:formRemote name="addStudents" url="[controller: 'scheduledCourse',action: 'addStudents']"
                update="statusAfterAddStudents" before="beforeAddStudentsToCourse();"
                after="afterAddStudentsToCourse();">
    Datos separados por coma:<br/>
    <i>correo,nombre,apellidos</i><br/>
    Ejemplo: <b>mail@mail.com,Juan,Reyes Zuñiga</b><br/>
    <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
    <g:textArea name="studentsData" rows="10" cols="30"/><br/>
    <input type="submit" name="send" value="Add this students"/>
  </g:formRemote>
  <div id="statusAfterAddStudents"></div>
</div>