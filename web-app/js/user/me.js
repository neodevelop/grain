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

  $('.nav-tabs li a:first').tab('show');

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

function removeRegistration(registrationId){
  $("#registration"+registrationId).fadeOut('slow');
}

function showPaymentForRegistration(){
  $('#modalPayment').modal('show');
}

function hidePaymentForRegistration(){
  var paymentForm = $("#editPaymentForm");
  if(paymentForm.is(":visible")){
    paymentForm.hide();
  }
  $('#modalPayment').modal('hide');
}

function addPaymentToRegistration(data){
  var row = $("table#payments tbody tr:first").clone().removeClass("cloneable");
  var numberPayment = $("table#payments tbody tr:last td:first").text();
  row.find("span[title=paymentNumber]").text((numberPayment*1) + 1);
  row.find("span[title=paymentAmount]").text("$ "+data.amount);
  row.find("span[title=paymentStatus]").text(data.paymentStatus.name);
  row.find("span[title=paymentKind]").text(data.kindOfPayment.name);
  row.appendTo("table#payments tbody").removeClass("hide").fadeIn();
}

function showActionsForEdit(){
  $("#editPaymentForm").show();
}

function paymentEditOk(data){
  var paymentForm = $("#editPaymentForm");
  paymentForm.hide();
  $("#editMessage span#messageForEditAction").text(data);
  $("#editMessage").show();
}