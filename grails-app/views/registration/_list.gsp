<%@ page import="com.synergyj.grain.course.KindOfPayment; com.synergyj.grain.course.PaymentStatus; com.synergyj.grain.course.RegistrationStatus" %>
  <table class="table table-striped">
    <thead>
      <tr>
        <th>#</th>
        <th>Curso</th>
        <th>Fecha de inicio</th>
        <th>Duración</th>
        <th>Status</th>
        <th>&nbsp;</th>
      </tr>
    </thead>
    <tbody>
      <g:each in="${registrationList}" var="registration" status="i">
      <tr>
        <td>${i+1}</td>
        <td>${registration.scheduledCourse.course.name}</td>
        <td>
          <g:formatDate date="${registration.scheduledCourse.beginDate}" format="dd-MMMM-yy" locale="es" />
        </td>
        <td>${registration.scheduledCourse.durationInHours} hrs.</td>
        <td>
          ${g.message(code:registration.registrationStatus.code)}
        </td>
        <td>
          <g:if test="${registration.registrationStatus == RegistrationStatus.REGISTERED}">
            <g:link mapping="payment" class="btn btn-primary" id="${registration.id}">
              <g:message code="payment.payit"/>
            </g:link>
          </g:if>
          <g:if test="${registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH}">
            <span class="label label">Atento!</span>
            Ya has iniciado tu proceso de pago, revisa tu historial de pagos.
          </g:if>
          <g:if test="${registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_WITH_DEBTH_IN_GROUP}">
            <span class="label label-warning"><i class="icon-ok icon-white"></i> Bien!</span>
            Estás en el grupo, sin embargo, aún tienes pago(s) pendientes(s) o por procesar.
          </g:if>
          <g:if test="${registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_PAYED}">
            <span class="label label-info">Excelente!</span>
            Ya has pagado, en breve te agregamos al grupo.
          </g:if>
          <g:if test="${registration.registrationStatus == RegistrationStatus.INSCRIBED_AND_PAYED_IN_GROUP}">
            <span class="label label-success">Bienvenido!</span>
            Ya has pagado completamente y estás totalmente registrado.
          </g:if>
          <g:if test="${registration.registrationStatus == RegistrationStatus.FINISHED}">
            <div class="btn-group">
              <g:link controller="studentsGroup" action="certificate" id="${registration.id}" class="btn">
                <i class="icon-download-alt"></i>
                <g:message code="registration.certificate"/>
              </g:link>
              <g:hasEvaluationForCourse scheduledCourseId="${registration.scheduledCourse.id}">
                <g:link class="btn" controller="evaluation" action="index" id="${registration.scheduledCourse.id}">
                  <i class="icon-th-list"></i>
                  <g:message code="evaluation.do" default="Begin evaluation for this course"/>
                </g:link>
            </g:hasEvaluationForCourse>
            </div>
          </g:if>
          <g:if test="${registration.registrationStatus == RegistrationStatus.CANCELLED}">
            <span class="label label-inverse">Disculpa!</span>
            Este registro ha sido cancelado
          </g:if>
        </td>
      </tr>
      </g:each>
    </tbody>
  </table>