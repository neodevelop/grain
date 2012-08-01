<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html lang="es" class="no-js">
<!--<![endif]-->
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    ${r.external(uri:'images/ico.png')}
    <title>. : SynergyJ - <g:layoutTitle default="Entrenamiento"/> : .</title>
    <ga:trackPageviewAsynch />
    <r:require module="bootstrap-js"/>
    <r:require module="bootstrap-css"/>
    <g:layoutHead/>
    <r:layoutResources />
  </head>
  <body>

    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#"><r:img uri="/images/ico.png" width="16"/>&nbsp;SynergyJ.com</a>
          <div class="nav-collapse">
            <ul class="nav">
              <g:set var="options" value="${menu.options(name:'top')}"/>
              <g:if test="${options}">
                <g:each in="${options}" var="option">
                  <li>
                    <a href="${menu.link(option:option)}">
                      ${g.message(code:option.item.labelCode, default:option.item.labelCode)}
                    </a>
                  </li>
                </g:each>
              </g:if>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container">
      <g:layoutBody/>  

      <footer>
        <p>&copy; SynergyJ Servicios Profesionales  - 2012</p>
      </footer>
    </div> <!-- /container -->

    <r:layoutResources />
  </body>
</html>