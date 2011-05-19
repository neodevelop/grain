<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<g:render template="/themes/wb/includes/head"/>
<body>
<div id="container2">
  <div id="wrapper">
    <g:render template="/themes/wb/includes/topMenu"/>
    <g:render template="/themes/wb/includes/header"/>
    <!-- Begin Content  -->
    <div id="content">
      <g:if test="${flash.message}">
        <div class="ui-state-highlight ui-corner-all" style="margin-top: 10px; padding: 0 .7em;">
          <p>
            <span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;"></span>
            <strong>Oye!</strong> ${flash.message}
          </p>
        </div>
      </g:if>
      <g:if test="${flash.error}">
        <div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
          <p>
            <span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span>
            <strong>Alerta:</strong> ${flash.error}
          </p>
        </div>
      </g:if>
      <g:layoutBody/>
    </div>
    <!-- End Content  -->
  </div>
</div>
<g:render template="/themes/wb/footer"/>
</body>
</html>
