  <g:if test="${flash.warning}">
  <div class="alert alert-block">
    <button data-dismiss="alert" class="close" type="button">×</button>
    <h4 class="alert-heading">Cuidado!</h4>
    <p>${flash.warning}</p>
  </div>
  </g:if>
  <g:if test="${flash.error}">
  <div class="alert alert-error">
    <button data-dismiss="alert" class="close" type="button">×</button>
    <h4 class="alert-heading">Error!</h4>
    <p>${flash.error}</p>
  </div>
  </g:if>
  <g:if test="${flash.success}">
  <div class="alert alert-success">
    <button data-dismiss="alert" class="close" type="button">×</button>
    <h4 class="alert-heading">Bien hecho!</h4>
    <p>${flash.success}</p>
  </div>
  </g:if>
  <g:if test="${flash.info}">
  <div class="alert alert-info">
    <button data-dismiss="alert" class="close" type="button">×</button>
    <h4 class="alert-heading">Importante!</h4>
    <p>${flash.info}</p>
  </div>
  </g:if>
  <g:if test="${flash.message}">
  <div class="alert alert-info">
    <button data-dismiss="alert" class="close" type="button">×</button>
    <strong>Atención!</strong> ${flash.message}
  </div>
  </g:if>