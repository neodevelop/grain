$(document).ready(function(){
  $(":radio").hide();
  $("div.payment").hide();
  $("span#paymentAmountSpei").text($("input[name=totalToPay]").val());
  $("span#paymentAmountDM").text($("input[name=totalToPay]").val());
  $("div.paymentOption").click(function(){
    $("div.payment").hide();
    $("div#rightbox :radio").attr("checked",false);
    $(":first",this).attr("checked",true);
    highlight(this,"paymentOption",".groupOption2");
    if($("input[name='paymentOption']:checked").val() == 'transferencia'){
      $("div#paymentSpei").slideDown('slow');
    }else{
      $("div#paymentDineroMail").slideDown('slow');
    }
    $.scrollTo($(document).height(), 'fast');
  });
  $("a.submit").click(function(){
    $("form#makePayment").submit();
    return false;
  });
});

function highlight(selector,clazz,group){
  $(group).removeClass("optionSelected");
  $(group).addClass(clazz);
  $(selector).removeClass(clazz);
  $(selector).addClass("optionSelected");
}