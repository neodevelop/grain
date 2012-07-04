$(function(){

  $("form#fileuploadForm").live("submit",function(){
    $("#okMessage").hide();
    $("#errorMessage").hide();
    $(this).ajaxSubmit({
      clearForm: true,
      resetForm: true,
      beforeSubmit:function(formData, jqForm, options){
        $("input#sendReceipt").hide();
        $("input#file").addClass("disabled");
        $("#loaderProgressBar").fadeIn('slow');
      },
      success:function(data){
        var linkId = $("#paymentNumber").val();
        $("a[name=uploadReceipt"+linkId+"]").hide();
        $("#okMessage").text(data);
        $("#okMessage").fadeIn();

      },
      error:function(jqXHR, textStatus, errorThrown){
        $("#errorMessage").text(errorThrown);
        $("#errorMessage").fadeIn();
      },
      complete:function(jqXHR, textStatus){
        $("#loaderProgressBar").fadeOut('slow');
        $("form#fileuploadForm").fadeOut();
        $("input#file").removeClass("disabled");
        $("input#sendReceipt").show();
      }
    });
    return false;
  });

  $('.nav-tabs li a:first').tab('show');

  $("a[name^='uploadReceipt']").live("click",function(){
    var form = $("form#fileuploadForm");
    form.show();
    var number = $(this).attr('name').substring("uploadReceipt".length);
    form.find("#paymentNumber").val(number);
    return false;
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
  $("#okMessage span#messageForOkStatus").text("El pago se ha modificado");
  $("#okMessage").show();
  $("tr#payment" + data.id).find("td:last").html("<span class='label label-success'>Modificado</span>");
}

function paymentDeleted(data){
  $("tr#payment"+data.id).fadeOut();
  $("#okMessage span#messageForOkStatus").text("El pago se ha eliminado");
  $("#okMessage").show();
}