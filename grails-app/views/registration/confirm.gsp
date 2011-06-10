<html>
  <head>
    <meta name="layout" content="wb" />
    <title><g:message code="registration.confirm" default="Confirm registration" /></title>
    <parameter name="pageHeader" value="${g.message(code: 'registration.confirm', default: 'Confirm Registration')}"/>
    <script type="text/javascript" src="https://raw.github.com/malsup/form/master/jquery.form.js"></script>
    <g:javascript>
      $(function(){
        $("form#auth").ajaxForm({
          dataType:'json',
          success:function(json){
            if (json.success) {
              if (json.url) {
                document.location = json.url;
              }
              else {
                $("#leftbox > #loadProfile").load("${createLink(controller:'user',action:'simpleProfile')}");
                $("#confirm").show();
                $("#profile").hide()
                $("#loginForm").hide()
              }
            }
            else if (json.error) {
              $('#jsonMessage').html(json.error);
              $("#loginMessage").show();
            }
            else {
              $('#jsonMessage').html(responseText);
              $("#loginMessage").show();
            }
          }
        });

        $("a#notme").live('click',function(){
          $("#profile").hide();
          $("#loginForm").show();
          return false;
        });


      });
    </g:javascript>
  </head>
  <body>
  <div id="left">
    <div id="leftbox">
      <div id="loadProfile"></div>
      <g:render template="/login/form" model="[email:email,postUrl:postUrl,rememberMeParameter:rememberMeParameter]"/>
      <g:render template="/login/logged"/>
    </div>

    <div id="confirm" style="display:<sec:ifLoggedIn>block</sec:ifLoggedIn><sec:ifNotLoggedIn>none</sec:ifNotLoggedIn>;">
      <g:link controller="registration" params="[scheduledCourseId:scheduledCourse.id]" class="button">Confirmar registro</g:link>
    </div>

  </div>
  <div id="right">
    <div id="rightbox">
      <h1>Información del curso</h1>
      <h2>${scheduledCourse.course}</h2>
      <div class="info">
        Fecha de inicio: <b><g:formatDate date="${scheduledCourse.beginDate}" format="dd - MMMM - yyyy"/></b> <br/>
        Fecha limite de registro: <b><g:formatDate date="${scheduledCourse.limitRegistrationDate}" format="dd - MMMM - yyyy"/></b>
      </div>
      <div id="price">
        Costo: $ <g:formatNumber number="${scheduledCourse.costByCourse}" format="#,###.00"/>
      </div>
    </div>
  </div>
  </body>
</html>