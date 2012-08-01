<h3><div id="courseName">${registration.scheduledCourse.course.name}</div></h3>

<dl class="dl-horizontal">
  <dt><g:message code="course.originalPrice"/>:</dt>
  <dd>
    &nbsp;$ <span id="originalPrice"><g:formatNumber number="${registration.scheduledCourse.costByCourse}" format="###,##0.00" locale="es_MX"/>
    </span>
    <g:hiddenField name="costByCourse" value="${registration.scheduledCourse.costByCourse}"/>
  </dd>
  <dt class="discount" style="display:none;">
    <g:message code="course.discount"/>:
  </dt>
  <dd class="discount" style="display:none;">
    - $ <span id="discountAmount">
    <g:formatNumber number="${discount}" locale="es_MX" format="###,##0.00"/>
    </span>
  </dd>
  <dt class="priceWithDiscount" style="display:none;">
    <g:message code="course.priceDiscount"/>:
  </dt>
  <dd class="priceWithDiscount" style="display:none;">
    &nbsp;$ <span id="priceWithDiscount">
      <g:formatNumber number="${finalAmount}" locale="es_MX" format="###,##0.00"/>
    </span>
  </dd>
  <dt class="taxIva" style="display:none;">
    <g:message code="course.tax"/>:
  </dt>
  <dd class="taxIva" style="display:none;">
    &nbsp;$ <span id="taxIvaAmount">
      <g:formatNumber number="${iva}" locale="es_MX" format="###,##0.00"/>
    </span>
  </dd>
  <dt class="finalPrice">
    <g:message code="course.finalPrice"/>:
  </dt>
  <dd class="finalPrice finalAmount">
    &nbsp;$ <span id="finalAmount">
      <g:formatNumber number="${registration.scheduledCourse.costByCourse}" locale="es_MX" format="\$ ###,##0.00"/>
    </span>
  </dd>
</dl>