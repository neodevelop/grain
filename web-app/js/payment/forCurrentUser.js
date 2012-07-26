$(function(){
  $("a[name*=uploadReceipt]").click(function(){
    $('#fileuploadForm').show();
    $('input[name=paymentNumber]').val($(this).attr("name").substring('uploadReceipt'.length));
    $('#uploadReceiptForPaymentModal').modal('show')
  });
  $("form#fileuploadForm").submit(function(){ // TODO: Código duplicado
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
        $("#messageForOkStatus").text(data);
        $("#okMessage").fadeIn();

      },
      error:function(jqXHR, textStatus, errorThrown){
        $("#messageForErrorStatus").text(errorThrown);
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
});