$(function(){
  var links = $("div.pagination").children();
  links.wrapAll("<ul/>");
  links.each(function(){
    $(this).wrap("<li/>");
  });
  var active = $("span.currentStep");
  active.parent().addClass("active");
  active.wrap("<a href='#'/>");
});