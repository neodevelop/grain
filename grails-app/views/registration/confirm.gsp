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
          $("#confirm").hide();
          $("form#auth").each(function(){
            this.reset();
          });
          $("#username").focus();
          return false;
        });

      });
    </g:javascript>
  </head>
  <body>
  <div id="left">
    <div id="leftbox">
      <div id="loadProfile"></div>
      <g:render template="/login/form" model="[email:email,postUrl:postUrl,rememberMeParameter:rememberMeParameter,scheduledCourseId:scheduledCourse.id]"/>
      <g:render template="/login/logged"/>
    </div>

    <div id="confirm" style="display:<sec:ifLoggedIn>block</sec:ifLoggedIn><sec:ifNotLoggedIn>none</sec:ifNotLoggedIn>;">

        <g:if test="${flash.message}">
          <g:link mapping="me" class="button">
          <g:message code='login.goMe' default="Go to my profile"/>
          </g:link>
        </g:if>
        <g:else>
          <g:link controller="registration" action="addMeToCourse" params="[scheduledCourseId:scheduledCourse.id]" class="button">
            <g:message code='registration.confirm' default="Confirm registration"/>
          </g:link>
        </g:else>
    </div>

  </div>
  <div id="right">
    <div id="rightbox">
      <h1><g:message code='course.info'/></h1>
      <h2>${scheduledCourse.course}</h2>
      <div class="info">
        <g:message code='course.startDate'/> : <b><g:formatDate date="${scheduledCourse.beginDate}" format="dd - MMMM - yyyy"/></b> <br/>
        <g:message code='course.limitDate'/> : <b><g:formatDate date="${scheduledCourse.limitRegistrationDate}" format="dd - MMMM - yyyy"/></b>
      </div>
      <div id="price">
        <g:message code='course.cost'/> : $ <g:formatNumber number="${scheduledCourse.costByCourse}" format="#,###.00"/>
      </div>
    </div>
  </div>
  </body>
</html>