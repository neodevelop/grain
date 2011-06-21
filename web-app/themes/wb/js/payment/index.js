$(function(){
  startOver();
});

function startOver(){
  $("input[name^=email]").blur(function(){
    var email = $(this).val();
    if(isValidEmailAddress(email)){
      $(this).siblings(":checkbox").attr('checked', true);
      $(this).parent().removeClass('uncheck').addClass('check');
      $(this).siblings("span").removeClass("optionUncheck").addClass("optionCheck");
      recalculateAmounts();
    }else{
      $(this).siblings(":checkbox").attr('checked', false);
      $(this).parent().removeClass('check').addClass('uncheck');
      $(this).siblings("span").removeClass("optionCheck").addClass("optionUncheck");
      recalculateAmounts();
    }
    $(this).siblings(":checkbox").trigger("change");
  });

  $("ul#promotions > li.select").click(function(){
    if($(this).children(":checkbox").attr("checked")){
      $(this).children(":checkbox").attr("checked",false);
      $(this).children("span").removeClass("optionCheck").addClass("optionUncheck");
    }else{
      $(this).children(":checkbox").attr("checked",true);
      $(this).children("span").removeClass("optionUncheck").addClass("optionCheck");
    }
    $(this).toggleClass('uncheck');
    $(this).toggleClass('check');
    $(this).children(":checkbox").trigger("change");
    recalculateAmounts();
  });

  $(":radio").hide();

  $("div.percentOption").click(function(){
    $("div#leftbox :radio").attr("checked",false);
    $(":first",this).attr("checked",true);
    highlight(this,"percentOption",".groupOption1");
  });

  $("div.paymentOption").click(function(){
    $("div#rightbox :radio").attr("checked",false);
    $(":first",this).attr("checked",true);
    highlight(this,"paymentOption",".groupOption2");
  });

  $(":checkbox").change(function(){
    recalculateAmounts();
  });
}

function isValidEmailAddress(emailAddress) {
  var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
  return pattern.test(emailAddress);
}

function disabledOptions(){
  $("div#rightbox input").attr("disabled",true);
  $("ul#promotions > li.select").removeClass("select");
  $("ul#promotions > li").unbind("click");
  $("div#applyPromotions").hide();
  $("p#reset").show();
}

function highlight(selector,clazz,group){
  $(group).removeClass("optionSelected");
  $(group).addClass(clazz);
  $(selector).removeClass(clazz);
  $(selector).addClass("optionSelected");
}

function recalculateAmounts(){
  var costByCourse = $("#costByCourse").val();
  var finalCostCourse = costByCourse;

  var discount = 0;

  $.each($("input[name='discount']:checked"),function(){
    discount += ($(this).val() / 1);
  });

  if(discount > 0){
    var discountAmount = finalCostCourse * (discount/100);
    var priceWithDiscount = finalCostCourse - discountAmount;
    $("span#discountAmount").text(discountAmount);
    $("span#priceWithDiscount").text(priceWithDiscount);
    finalCostCourse = priceWithDiscount;
    $("tr.discount").fadeIn('slow').add("tr.priceWithDiscount").fadeIn('slow');
  }else{
    finalCostCourse = costByCourse;
    $("tr.discount").fadeOut('slow').add("tr.priceWithDiscount").fadeOut('slow');
  }

  if($("input[name='invoice']").is(":checked")){
    var taxIvaAmount = (finalCostCourse * 0.16);
    finalCostCourse = (finalCostCourse*1) + (taxIvaAmount*1);
    $("span#taxIvaAmount").text(taxIvaAmount);
    $("tr.taxIva").fadeIn('slow');
  }else{
    $("tr.taxIva").fadeOut('slow');
  }

  $("span#finalAmount").text(finalCostCourse);
  $("span#totalCostByCourse").text(finalCostCourse);
  $("span#halfCostByCourse").text(finalCostCourse/2);

}