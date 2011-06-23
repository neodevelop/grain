$(function(){
  startOver();
  recalculateAmounts(false);
  highlightOnce();
  activateSendButtons();
});

function activateSendButtons(){
  $("div#finish > a.submit").click(function(){
    $("form#makePayment").trigger('submit');
    return false;
  });
}

function highlightOnce(){
  $("ul#promotions li").qtip({
      content: {
        text: 'Hey! antes de continuar checa las promociones...'
      },
      position: {
        my: "bottom center", // Use the corner...
        at: "top center", // ...and opposite corner
        target:$("ul#promotions")
      },
      show: {
        ready:true,
        event: false,
        effect: function(offset) {
         $(this).fadeIn(1000);
        }
      },
      hide: {
        event:'mouseenter',
        target:$("div#right"),
        effect: function(offset) {
         $(this).fadeOut(1000);
        }
      },
      style: {
        classes: 'ui-tooltip-shadow ui-tooltip-dark'
      }
  });
}

function startOver(){
  $("input[name^=email]").blur(function(){
    var email = $(this).val();
    if(isValidEmailAddress(email)){
      $(this).siblings(":checkbox").attr('checked', true);
      $(this).parent().removeClass('uncheck').addClass('check');
      $(this).siblings("span").removeClass("optionUncheck").addClass("optionCheck");
      recalculateAmounts(true);
    }else{
      $(this).siblings(":checkbox").attr('checked', false);
      $(this).parent().removeClass('check').addClass('uncheck');
      $(this).siblings("span").removeClass("optionCheck").addClass("optionUncheck");
      recalculateAmounts(true);
    }
    $(this).prev(":checkbox").trigger("change");
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
  });

  $(":radio").hide();

  $("div.percentOption").click(function(){
    $("div#leftbox :radio").attr("checked",false);
    $(":first",this).attr("checked",true);
    highlight(this,"percentOption",".groupOption1");
    bothSelected();
  });

  $("div.paymentOption").click(function(){
    $("div#rightbox :radio").attr("checked",false);
    $(":first",this).attr("checked",true);
    highlight(this,"paymentOption",".groupOption2");
    bothSelected();
  });

  $(":checkbox").change(function(){
    recalculateAmounts(true);
  });
}

function bothSelected(){
  $("div.payment").hide();
  if($("input[name='percentOption']").is(":checked") && $("input[name='paymentOption']").is(":checked")){
    if($("input[name='paymentOption']:checked").val() == 'transferencia'){
      $("div#paymentSpei").slideDown('slow');
      $("span#paymentAmountSpei").text($("input[name='percentOption']:checked").val());
      $("input[name='percentOption']")
    }else{
      $("div#paymentDineroMail").slideDown('slow');
      $("span#paymentAmountDM").text($("input[name='percentOption']:checked").val());
    }
    $.scrollTo($(document).height(), 'fast');
  }
}

function isValidEmailAddress(emailAddress) {
  var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
  return pattern.test(emailAddress);
}

function highlight(selector,clazz,group){
  $(group).removeClass("optionSelected");
  $(group).addClass(clazz);
  $(selector).removeClass(clazz);
  $(selector).addClass("optionSelected");
}

function recalculateAmounts(animate){
  var costByCourse = $("#costByCourse").val();
  var finalCostCourse = costByCourse;

  var discount = 0;
  var discountsId = [];

  $.each($("input[name='discount']:checked"),function(){
    discount += ($(this).val() / 1);
    discountsId.push(($(this).attr('id')).substring('discount'.length));
  });

  $("#checkedPromotions").val(discountsId.join(','));

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

  $("#half").val(finalCostCourse/2);
  $("#full").val(finalCostCourse);

  $("#totalToPay").val(finalCostCourse);

  if(animate){
    $("td.finalAmount").qtip({
      content: {
        text: 'Hey! mira...'
      },
      position: {
        my: "center left", // Use the corner...
        at: "center right", // ...and opposite corner
        target:$("td.finalAmount")
      },
      show: {
        event:false,
        ready:true,
        effect: function(offset) {
         $(this).fadeIn(1000);
        }
      },
      hide: {
        target:$("ul#promotions li").add("div#needInvoice"),
        effect: function(offset) {
         $(this).fadeOut(1000);
        }
      },
      style: {
        classes: 'ui-tooltip-shadow ui-tooltip-plain'
      }
    });
    $("td.finalAmount").qtip('reposition');
  }

  if($("div.payment").is(":visible")){
    bothSelected();
  }
}