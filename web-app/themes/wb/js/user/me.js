$(function(){

  $("#fileuploadForm").submit(function(){
    $("#okMessage").hide();
    $("#errorMessage").hide();
    $(this).ajaxSubmit({
          beforeSubmit:function(formData, jqForm, options){
            $("input.continue").hide();
            $("#fileupload").fadeIn('slow');
          },
          success:function(data){
            var linkId = $("#paymentNumber").val();
            $("<span>Procesando</span>").insertBefore("a[name=uploadReceipt"+linkId+"]");
            $("a[name=uploadReceipt"+linkId+"]").hide();
            $("#okMessage").text(data);
            $("#okMessage").fadeIn();
            $('#userDataForm').delay(4000).fadeOut(300);
            $('#lightbox').delay(4000).effect('clip',{},500,function(){});
          },
          error:function(jqXHR, textStatus, errorThrown){
            $("#errorMessage").text(errorThrown);
            $("#errorMessage").fadeIn();
          },
          complete:function(){
            $("#fileupload").fadeOut('slow').delay(1000);
          }
        });
    return false;
  });

  $("div#tabs").tabs();
  $("#accordion").accordion({ header:'div.note' });
  $("a[name^='uploadReceipt']").click(function(){
    var number = $(this).attr('name').substring("uploadReceipt".length);
    $("#paymentNumber").val(number);
    $('#lightbox').css({width:'100%',height:'100%'}).fadeIn(500,function(){
      $("#userDataForm").fadeIn(300);
    });
    return false;
  });

  $('#lightbox').click(function(){
    $("img#currentReceipt").remove();
    $('#userDataForm').fadeOut(300);
    $('#lightbox').effect('clip',{},500,function(){});
  });

  $("a.seeReceipt").click(function(){
    var link = this;
    $('#lightbox').css({width:'100%',height:'100%'}).fadeIn(500,function(){
      $("<img src='"+ $(link).attr('href') +"' alt='receipt' title='receipt' id='currentReceipt'/>").appendTo("#imageReceipt");
      $("#imageReceipt").fadeIn();
    });
    return false;
  });

  $("img#currentReceipt").live('click',function(){
    $(this).remove();
    $('#lightbox').effect('clip',{},500,function(){});
  });
});

function removeReceipt(receiptId){
  $("#receipt"+receiptId).fadeOut('slow');
}