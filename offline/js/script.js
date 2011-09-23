$(document).ready(function(){
  $('#ver-temario').click(function(){
    $('#lightbox').css({width:'100%',height:'100%'}).fadeIn(500,function(){
      $('#agenda').fadeIn(300);						
    });
  });
  $('#inscribete-aqui').click(function(){
    $('#lightbox').css({width:'100%',height:'100%'}).fadeIn(500,function(){
      $('#inscription-form').fadeIn(300);						
    });				
  });			
  $('#lightbox,#close-lightbox').click(function(){
    $('#inscription-form').fadeOut(200);
    $('#agenda').fadeOut(300);	
    $('#lightbox').css({width:'0',height:'0'}).fadeOut(300);				
  });
  $('#email').focus(function(){
    if ($('#email').val()=='Email'){$('#email').val('')}				
  });
  $('#email').blur(function(){
    if (($('#email').val()=='Email')||($('#email').val()=='')){$('#email').val('Email')}				
  });	
  $('#password').focus(function(){
    if ($('#password').val()=='Password'){$('#password').val('')}				
  });
  $('#password').blur(function(){
    if (($('#password').val()=='Password')||($('#password').val()=='')){$('#password').val('Password')}				
  });
  $('#confirmar').focus(function(){
    if ($('#confirmar').val()=='Confirmar'){$('#confirmar').val('')}				
  });
  $('#confirmar').blur(function(){
    if (($('#confirmar').val()=='Confirmar')||($('#confirmar').val()=='')){$('#confirmar').val('Confirmar')}				
  });

  $('#inscription').submit(function(){
    $(this).ajaxSubmit({
      dataType:'json',
      beforeSubmit:prepareVisualForm,
      success:processJson,
      complete:completeRequest,
      error:processError
    });
    return false;
  });
});	

function processError(jqXHR, textStatus, errorThrown){
  var data = $("#inscription").serialize();
  var url = $("#inscription").attr("action");
  window.location.href = url+'NoPost?'+data;
  var message = "<div id='message' class='error' style='display:none;'>"+errorThrown;
  message += "<br/><i>Redireccionando...</i></div>";
  $('div#messageInfo').fadeOut('slow');
  $(message).insertAfter("div#messageInfo").delay(1000).fadeIn('slow');
}

function processJson(data){
  var message = "";
  if(!data){
    message = "<div id='message' class='error' style='display:none;'>Una disculpa!!! No hemos podido procesar tu petici&oacute;n";
    message += "<br/><i>Servicio no disponible</i></div>";
  }else{
    if(data.url){
      message = "<div id='message' class='ok' style='display:none;'>Gracias !!! Te hemos enviado un correo";
      message += "<br/><i>O bien, si deseas continuar haz clic <a href='"+data.url+"'>aqu&iacute;</a></i></div>";
    }else{
      if(data.message){
        message = "<div id='message' class='error' style='display:none;'>";
        message += data.message + "</div>";
      }else{
        message = "<div id='message' class='error' style='display:none;'>Una disculpa!!! No hemos podido procesar tu petici&oacute;n";
        message += "<br/><i>Por favor intenta más tarde...</i></div>";
      }
    }
  }
  $('div#messageInfo').fadeOut('slow');
  $(message).insertAfter("div#messageInfo").delay(1000).fadeIn('slow');
}

function prepareVisualForm(formData, jqForm, options) {
  $('div#messageInfo').fadeIn('slow');
  $("div#message").remove();
  var email = $("#email").val();
  if(email != 0){
    if(isValidEmailAddress(email)){
      $("#validEmail").css({ "background-image": "url('images/validYes.png')" });
      return true;
    }else{
      $("#validEmail").css({ "background-image": "url('images/validNo.png')" });
      $('div#messageInfo').fadeOut('slow');
      return false;
    }
  }else{
    $("#validEmail").css({ "background-image": "url('images/validNo.png')" });
    $('div#messageInfo').fadeOut('slow');
    return false;
  }
}

function completeRequest(){
  $('div#messageInfo').fadeOut('slow');
}

function isValidEmailAddress(emailAddress) {
  var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
  return pattern.test(emailAddress);
}