function addStudentToGroup(studentRowId){
  $("table#studentsNoGroup tbody tr#student"+studentRowId).appendTo("table#studentsInGroup tbody");
  $("table#studentsInGroup tbody tr#student"+studentRowId+" td a").remove();
}

function removeStudentFromGroup(studentRowId){
  $("table#studentsInGroup tbody tr#student"+studentRowId).appendTo("table#studentsNoGroup tbody");
  $("table#studentsNoGroup tbody tr#student"+studentRowId+" td a").remove();
}