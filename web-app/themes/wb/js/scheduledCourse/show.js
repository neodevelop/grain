$(function(){
  $('#sessionStartTime').datepicker({ dateFormat:"dd/mm/yy" });
  $('#sessionHourStartTime').timepicker();

  $('#showAddCourseSession').click(function(){
    $('#newSessionCourse').show();
    $('#showAddCourseSession').hide();
  });
  
  $('#showAddExpense').click(function(){
    $('#newExpense').show();
    $('#showAddExpense').hide();
  });

  $('#showAddInstructor').click(function(){
      $('#newInstructor').show();
      $('#showAddInstructor').hide();
    });

  $("a.deleteSession").live("click",function(){
    var splitLink = this.href.split('/');
    var index = splitLink[splitLink.length - 1];
    $.ajax({
      type:'POST',
      url:this.href,
      success:function(data){
        $("li#sessionCourse"+index).fadeOut('slow');
      },
      error:function(){
        alert("Couldn't delete session");
      }
    });
    return false;
  });

  $("a.updateSession").live("click",function(){
    $('#newSessionCourse').show();
    var splitLink = this.href.split('/');
    var index = splitLink[splitLink.length - 1];
    var fullDate = $("span#sessionCourseValue"+index).text();
    var splitDate = fullDate.split(' ');
    $("#sessionStartTime").val(splitDate[0]);
    $("#sessionHourStartTime").val(splitDate[1]);
    $("#courseSessionId").val(index);
    return false;
  });
});

function restoreLink(){
  $('#newSessionCourse').hide();
  $('#showAddCourseSession').show();
  return false;
}

function restoreForm(){
  $('#newExpense').hide();
  $('#showAddExpense').show();
  $('#addExpenseToScheduledCourse')[0].reset();
  return false;
}

function restoreInstructorButton(){
  $('#newInstructor').hide();
  $('#showAddInstructor').show();
}

function addToInstructors(elementId){
  $("li#instructor"+elementId).appendTo("ul#instructors");
}

function removeFromInstructors(elementId){
  $("li#instructor"+elementId).appendTo("ul#selectInstructors");
}

function reacting(e){
  var date = new Date(e.sessionStartTime)
  var stringdate = date.getDate()+"/"+(date.getMonth()+1)+"/"+date.getFullYear()+" "+ date.getUTCHours()+":"+date.getMinutes();
  var link = "<a class='deleteSession' id='"+e.id+"' href='${createLink(controller:'courseSession',action:'deleteAsync')}/"+e.id+"'>Delete</a>";
  if($("#courseSessionId").val() > 0){
    $("div#sessionList > ul li#sessionCourse"+$("#courseSessionId").val()).replaceWith("<li id='sessionCourse"+e.id+"'>"+stringdate+" "+link+"</li>");
  }else{
    $("<li id='sessionCourse"+e.id+"'>"+stringdate+" "+link+"</li>").appendTo("div#sessionList > ul");
  }
  $("#courseSessionId").val(0);
}

function addExpenseToTable(expense){
  var date = new Date(expense.expenseTime)
  var stringdate = date.getDate()+"/"+(date.getMonth()+1)+"/"+date.getFullYear()+" "+ date.getUTCHours()+":"+date.getMinutes();
  var newRow = $("table#expenseList tbody > tr.expense").clone().removeClass("expense");
  newRow.find('.description').text(expense.description);
  newRow.find('.amount').text(expense.amount);
  newRow.find('.expenseCategory').text(expense.expenseCategory.name);
  newRow.find('.expenseTime').text(stringdate);
  newRow.appendTo("table#expenseList tbody").fadeIn();
}

function beforeAddStudentsToCourse(){
  $("div#statusAfterAddStudents").hide();
}

function afterAddStudentsToCourse(){
  $("div#statusAfterAddStudents").fadeIn();
}