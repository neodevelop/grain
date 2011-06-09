<html>
  <head>
    <meta name="layout" content="wb" />
    <title><g:message code="registration.confirm" default="Confirm registration" /></title>
    <parameter name="pageHeader" value="${g.message(code: 'registration.confirm', default: 'Confirm Registration')}"/>
    <script type="text/javascript" src="https://raw.github.com/malsup/form/master/jquery.form.js"></script>
    <g:javascript>
      $(function(){
        $("form#loginForm").ajaxForm({
          dataType:'json',
          success:function(json){
            alert(json.error);
            if (json.success) {
              if (json.url) {
                alert(json.url);
              }
              else {
                alert(json.username );
              }
            }
            else if (json.error) {
              $('#jsonMessage').html(json.error);
              $("#loginMessage").fadeIn();
            }
            else {
              $('#jsonMessage').html(responseText);
              $("#loginMessage").fadeIn();
            }
          }
        });
      });
    </g:javascript>
  </head>
  <body>
  <div id="left">
    <div id="leftbox">
      <sec:ifNotLoggedIn>
        <g:render template="/login/form" model="[email:email,postUrl:postUrl,rememberMeParameter:rememberMeParameter]"/>
      </sec:ifNotLoggedIn>
      <sec:ifLoggedIn>
        <g:render template="/login/logged"/>
      </sec:ifLoggedIn>
    </div>
    <sec:ifLoggedIn>
      <div id="confirm">
        <a href="#" class="button">Confirmar registro</a>
      </div>
    </sec:ifLoggedIn>
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