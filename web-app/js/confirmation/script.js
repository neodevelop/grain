$(document).ready(function(){
	$("#validEmail").hide();
	$("#noValidEmail").hide();	
	
  $('#email').focus(function(){
    if ($('#email').val()=='Email'){$('#email').val('')}				
  });
  $('#email').blur(function(){
    if (($('#email').val()=='Email')||($('#email').val()=='')){$('#email').val('Email')}				
  });	
     
  $("#inscription").submit(function() {
   try {
	   $("#validEmail").hide();
	   $("#noValidEmail").hide();
       
        return validaEmail();
    }catch(err) {
       alert(err);
    }
  });
});	

function validaEmail() {
	
	  $('#messageInfo').fadeIn('slow');
	  $("#message").remove();
	  var email = $("#email").val();
	  if(email != 0){
	    if(isValidEmailAddress(email)){
	      $("#validEmail").show();
	      return true;
	    }else{
	      $("#noValidEmail").show();
	      $('#messageInfo').fadeOut('slow');
	      return false;
	    }
	  }else{
	    $("#noValidEmail").show();
	    $('#messageInfo').fadeOut('slow');
	    return false;
	  }
}

function isValidEmailAddress(emailAddress) {
  var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
  return pattern.test(emailAddress);
}
