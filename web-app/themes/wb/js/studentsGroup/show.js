$(function() {
  $("div#tabs").tabs();
  $("div[id^=paymentsForRegistration]").dialog({ autoOpen: false, show: "blind", hide: "explode", width: 850 });
  $("a.showDialog").click(function(){
    var selector = $(this).attr('href');
    $(selector).dialog("open");
    return false;
  });
  $("table.paymentsDetails").styleTable();
  $("table.registrationsList").styleTable();
  $("table.expensesList").styleTable();
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