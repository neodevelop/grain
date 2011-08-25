$(function(){
  $("div.list table").styleTable();
});

function changeAttendanceStatus(data,elementId){
  var imgElement = $("span#sessionPerRegistration"+elementId+" > img");
  var src = imgElement.attr("src");
  var newSrc = "";
  if(data.attended){
    newSrc = src.replace("red","green");
  }else{
    newSrc = src.replace("green","red");
  }
  imgElement.attr("src",newSrc);
}