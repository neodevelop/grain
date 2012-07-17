<html>
  <head>
    <meta name="layout" content="main" />
    <r:require module="common"/>
    <title><g:message code="registration.confirm" default="Confirm registration" /></title>
    <r:script> 
      $(function(){
        $("form#auth").ajaxForm({
          dataType:'json',
          success:function(json){
            if (json.success) {
              $("#profile").remove();
              $("#extraInfo,#formActions").show();
              if (json.url) {
                document.location = json.url;
              }
              else {
                $("#loadProfile").load("${createLink(controller:'user',action:'simpleProfile')}");
                $("#loginForm").hide();
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
          $("#loginForm").show();
          $("#extraInfo,#formActions,#profile").hide();
          $("form#auth").each(function(){
            this.reset();
          });
          $("#username").focus();
          $("#loginMessage").hide();
          return false;
        });

      });
    </r:script>
  </head>
  <body>

  <div class="page-header">
    <h1>${g.message(code: 'course.info', default: 'Confirm Info')}
      <small>${message(code:'register.confirm',default:"Please confirm the info below.")}</small>
    </h1>
  </div>

  <div class="row">
    <div class="span6">
      <g:if test="${flash?.message}">
      <div class="alert alert-info">
        ${flash.message}
      </div>
      </g:if>
      <h2>Tus datos</h2>
      <p>Una notificación será enviada a tu correo</p>
      <div id="loadProfile"></div>
      <g:render template="/login/form" model="[email:email,postUrl:postUrl,rememberMeParameter:rememberMeParameter,scheduledCourseId:scheduledCourse.id]"/>
      <sec:ifLoggedIn>
        <g:render template="/login/logged"/>
      </sec:ifLoggedIn>
      <br/>
      <g:set var="visible" value="none"/>
      <sec:ifLoggedIn>
        <g:set var="visible" value="block"/>
      </sec:ifLoggedIn>
      <div id="extraInfo" class="well" style="display:${visible};">
        Recuerda completar los datos de tu perfil, principalmente tu <span class="label label-info">nombre</span>, pues con esa información generamos los reconocimientos de la manera correcta.
      </div>
      <div id="formActions" class="form-actions" style="display:${visible};">
        <g:if test="${flash?.message}">
          <g:link mapping="me" class="btn btn-info">
            <g:message code='login.goMe' default="Go to my profile"/>
          </g:link>
        </g:if>
        <g:else>
          <g:link controller="registration" action="addMeToCourse" params="[scheduledCourseId:scheduledCourse.id]" class="btn btn-success">
            <g:message code='registration.confirm' default="Confirm registration"/>
          </g:link>
        </g:else>
        <a href="#" id="notme" class="btn btn-inverse"><g:message code='login.notyou' default="aren't you? this is not me!"/></a>
      </div>
    </div>

    <div class="span6">
      <g:render template="/scheduledCourse/show" model="[scheduledCourse:scheduledCourse]"/>
    </div>
  </div>


  <script type="text/javascript" src="http://synergyj.com/resources/jquery.form.js"></script>
  </body>
</html>