<%@ page import="com.synergyj.grain.course.KindPromotion; com.synergyj.grain.course.RegistrationStatus" %>
<head>
  <title><g:message code='payment.info' default="Payment info"/></title>
  <meta name='layout' content='main'/>
  <r:require module="home"/>
  <r:require module="payment"/>
</head>
<body>

<div class="page-header">
  <h1>Comienza tu pago
    <small>${message(code:'payment.start',default:"Starting your payment you make sure you have a place reserved in this course.")}</small>
  </h1>
</div>
<g:form action="create" name="makePayment">
<div class="row">
  <div class="span6">
    <div class="well">

      <g:render template="/registration/simpleShow" model="[registration:registration]"/>
      
      <div class="percentOption groupOption1">
        <g:radio id="half" value="" name="percentOption"/>
        Aparta tu lugar con el 50% ( $ <span id="halfCostByCourse"></span> )
      </div>
      <div class="percentOption groupOption1">
        <g:radio id="full" value="" name="percentOption" checked="checked"/>
        Paga el total de tu curso ( $ <span id="totalCostByCourse"></span>  )
      </div>

    </div>
  </div>
  <div class="span6">
    <g:render template="/promotion/showForPayment" model="[promotionsPerCourse:promotionsPerCourse]" />
  </div>
</div>

<div class="row">
  <div class="span4">
    <h2>Pago en efectivo</h2>
    <g:render template="efectivo"/>
  </div>
  <div class="span4">
    <h2>Transferencia electrónica</h2>
    <g:render template="spei"/>
  </div>
  <div class="span4">
    <h2>Tarjetas de crédito</h2>
    <g:render template="tc"/>
  </div>
</div>

<g:hiddenField name="registrationId" value="${registration.id}"/>
<g:hiddenField name="totalToPay" value=""/>
<g:hiddenField name="checkedPromotions" value=""/>
</g:form>

</body>