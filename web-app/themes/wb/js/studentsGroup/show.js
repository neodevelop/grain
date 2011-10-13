$(function() {
  $("div#tabs").tabs();
});
function addStudent(studentRowId) {
  $("table#studentsNoGroup > tbody > tr#student" + studentRowId).clone().prependTo("table#studentsInGroup");
  $("table#studentsNoGroup > tbody > tr#student" + studentRowId).remove();
  $("table#studentsInGroup > tbody > tr#student" + studentRowId + " td a").remove();
}

function removeStudent(studentRowId) {
  $("table#studentsInGroup > tbody > tr#student" + studentRowId).clone().prependTo("table#studentsNoGroup");
  $("table#studentsInGroup > tbody > tr#student" + studentRowId).remove();
  $("table#studentsNoGroup > tbody > tr#student" + studentRowId + " td a").remove();
}