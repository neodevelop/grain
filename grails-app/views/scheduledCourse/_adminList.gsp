<%@ page import="com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.RegistrationStatus; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.ReceiptStatus" %>
  <ul class="nav nav-tabs">
    <g:each in="${scheduledCourseList}" var="scheduledCourse" status="i">
      <li>
        <a href="#sc-${i}" data-toggle="tab">
          ${scheduledCourse.course.courseKey}
        </a>
      </li>
    </g:each>
  </ul>
  <div id="myTabContent" class="tab-content">
    <g:each in="${scheduledCourseList}" var="scheduledCourse" status="i">
    <div id="sc-${i}" class="tab-pane fade">
      <h2>Comienza: <g:formatDate date="${scheduledCourse.beginDate}" format="EEEE dd-MM-yy"/> </h2>
      <g:each in="${RegistrationStatus.values()}" var="registrationStatus">
      <h3>${g.message(code:registrationStatus.code)}</h3>
      <table id="registrations_${registrationStatus}" width="100%" class="table table-striped table-bordered table-condensed">
        <thead>
          <tr>
            <th>Correo</th>
            <th>Nombre</th>
            <th>Registro</th>
            <th>Pagos</th>
            <th>Promociones</th>
          </tr>
        </thead>
        <tbody>
        <g:set var="identifierForScheduledCourse" value="${scheduledCourse.course.courseKey}${scheduledCourse.id}"/>
        <g:findAll in="${registrationsPerScheduledCourse[identifierForScheduledCourse]}" expr="it.registrationStatus == registrationStatus">
          <tr class="registrationRow" id="registration${it?.id}">
            <td>
              ${it?.student?.email}
            </td>
            <td>
              <g:if test="${it?.student?.firstName && it?.student?.lastName}">
                ${it?.student?.firstName ?: ''} ${it?.student?.lastName ?: ''}
              </g:if>
              <g:else>
                <span class="label label-important">No tiene nombre establecido</span>
              </g:else>
            </td>
            <td>
              <div class="btn-group">
                <button data-toggle="dropdown" class="btn dropdown-toggle">Registro <span class="caret"></span></button>
                <ul class="dropdown-menu">
                  <li><a href="#">Modificar registro</a></li>
                  <li><a href="#">Cancelar registro</a></li>
                </ul>
                <g:if test="${it?.registrationStatus == RegistrationStatus.REGISTERED}">
                <button href="#" class="btn btn-danger">Eliminar registro</button> 
                </g:if>
              </div>
            </td>
            <td>
              <div class="btn-group">
                <button data-toggle="dropdown" class="btn dropdown-toggle">Pagos <span class="caret"></span></button>
                <ul class="dropdown-menu">
                  <li><a href="#">Ver pagos</a></li>
                  <li><a href="#">Agregar pago</a></li>
                </ul>
              </div>
            </td>
            <td>
              <div class="btn-group">
                <button data-toggle="dropdown" class="btn dropdown-toggle">Promociones <span class="caret"></span></button>
                <ul class="dropdown-menu">
                  <li><a href="#">Ver promociones</a></li>
                  <li><a href="#">Agregar promoción</a></li>
                </ul>
              </div>
            </td>
          </tr>
        </g:findAll>
        </tbody>
      </table>
      </g:each>
    </div>
    </g:each>
  </div>