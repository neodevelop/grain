<div id="title">
<g:message code="course.name"/>:
<div id="courseName">${registration.scheduledCourse.course}</div>
</div>

<table id="breakDownDetail">
  <tr>
    <td width="50%"><g:message code="course.originalPrice"/>:</td>
    <td>
      $ <span id="originalPrice"><g:formatNumber number="${registration.scheduledCourse.costByCourse}" format="#,###.##"/></span>
      <g:hiddenField name="costByCourse" value="${registration.scheduledCourse.costByCourse}"/>
    </td>
  </tr>

  <tr class="discount" style="display:none;">
    <td><g:message code="course.discount"/>:</td>
    <td>
      - $ <span id="discountAmount"><g:formatNumber number="${discount}" format="#,###.##"/></span>
    </td>
  </tr>

  <tr class="priceWithDiscount" style="display:none;">
    <td><g:message code="course.priceDiscount"/>:</td>
    <td>
      $ <span id="priceWithDiscount"><g:formatNumber number="${finalAmount}" format="#,###.##"/></span>
    </td>
  </tr>

  <tr class="taxIva" style="display:none;">
    <td><g:message code="course.tax"/>:</td>
    <td>$ <span id="taxIvaAmount"><g:formatNumber number="${iva}" format="#,###.##"/></span></td>
  </tr>

  <tr class="finalPrice">
    <td><g:message code="course.finalPrice"/>:</td>
    <td class="finalAmount">
      $ <span id="finalAmount"><g:formatNumber number="${registration.scheduledCourse.costByCourse}" format="#,###.##"/></span>
    </td>
  </tr>
</table>
