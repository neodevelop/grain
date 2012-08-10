<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  ${r.external(uri:'/images/ico.png')}
  <title>. : SynergyJ - <g:layoutTitle default="Entrenamiento"/> : .</title>

  <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
  <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->

  <r:require module="bootstrap-js"/>
  <r:require module="bootstrap-css"/>
  <g:layoutHead/>
  <r:layoutResources />
</head>

<body>

<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container-fluid">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <a class="brand" href="#"><r:img uri="/images/ico.png" width="16"/>&nbsp;SynergyJ.com</a>
      <div class="btn-group pull-right">
        <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
          <i class="icon-user"></i>
          <sec:loggedInUserInfo field="username"/>
          <span class="caret"></span>
        </a>
        <ul class="dropdown-menu">
          <!-- TODO: Crear un perfil de usuario donde se muestre los cursos que ha tomado -->
          <!--li><a href="#">Profile</a></li-->
          <!--li class="divider"></li-->
          <li>
            <g:link controller="logout">
              Logout
            </g:link>
          </li>
        </ul>
      </div>
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

<div class="container-fluid">
  <div class="row-fluid">
    <div class="span3">
      <div class="well sidebar-nav">
        <ul class="nav nav-list">
          <sec:ifAnyGranted roles="ROLE_ADMIN" >
          <li class="nav-header">Administrador</li>
          <li class="active">
            <a href="#">Grupos</a>
          </li>
          <li>
            <a href="#">Cotizador de cursos</a>
          </li>
          <li>
            <a href="#">Rondas de cursos</a>
          </li>
          <li>
            <g:link controller="course">
              <g:message code="course.label" default="Courses"/>
            </g:link>
          </li>
          <li>
            <g:link controller="scheduledCourse">
              <g:message code="scheduledcourse.label" default="Scheduled Courses"/>
            </g:link>
          </li>
          <li>
            <g:link controller="promotion">
              <g:message code="promotion.label" default="Promotions"/>
            </g:link>
          </li>
          <li>
            <g:link controller="promotionPerScheduledCourse">
              <g:message code="promotionPerScheduledCourse.label" default="Promotion Per Course"/>
            </g:link>
          </li>
          <li>
            <g:link controller="content" class="action">
              <g:message code="content.label" default="Contents"/>
            </g:link>
          </li>
          <li>
            <g:link controller="notification" class="action">
              <g:message code="notification.label" default="Notifications"/>
            </g:link>
          </li>
          </sec:ifAnyGranted>
          <li class="nav-header">Personal</li>
          <li>
            <g:link mapping="mySessions" class="action">
              <i class="icon-calendar"></i>Mis sesiones
            </g:link>
          </li>
          <li>
            <g:link mapping="updateme" class="action">
              <i class="icon-user"></i>
              <g:message code="me.update"/>
            </g:link>
          </li>
          <li>
            <g:link mapping="myPayments" class="action">
              <i class="icon-file"></i>Mis pagos
            </g:link>
          </li>
          <li>
            <g:link mapping="changePassword" class="action">
              <i class="icon-exclamation-sign"></i>
              <g:message code="me.changePassword"/>
            </g:link>
          </li>
          <li>
            <g:link mapping="myAcademicHistorial" class="action">
              <i class="icon-time"></i>Mi historial
            </g:link>
          </li>
          <li>
            <a href="#">
              <i class="icon-leaf"></i>Configuración <span class="label">En progreso</span>
            </a>
          </li>
          <li>
            <a href="#">
              <i class="icon-comment"></i>Chat <span class="label">Próximamente</span>
            </a>
          </li>
          <li class="nav-header">Social <span class="label">Próximamente</span></li>
          <li><a href="#">Facebook </a></li>
          <li><a href="#">Twitter </a></li>
          <li><a href="#">Github </a></li>
        </ul>
      </div><!--/.well -->
    </div><!--/span-->
    <div class="span9">
      <g:render template="/common/flashMessagesAlerts"/>
      <g:layoutBody/>
    </div><!--/span-->
  </div><!--/row-->

  <hr>

  <footer>
    <p>&copy; SynergyJ Servicios Profesionales  - 2012</p>
  </footer>

</div>
<r:layoutResources />
</body>
</html>
