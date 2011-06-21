<h4><g:message code="course.name"/></h4>
<h3>${registration.scheduledCourse.course}:</h3>
<br>
<h4><g:message code="course.registrationDate"/>:</h4>
<h3><g:formatDate date="${registration.dateCreated}" format="EEEE dd-MMMM-yyyy"/></h3>
<br>

<table id="breakDownDetail">
  <tr>
    <td><g:message code="course.originalPrice"/>:</td>
    <td>$ <g:formatNumber number="${registration.scheduledCourse.costByCourse}" format="#,###.##"/></td>
  </tr>

  <tr class="discount">
    <td><g:message code="course.discount"/>:</td>
    <td>
      - $ <span id="discountAmount"><g:formatNumber number="${discount}" format="#,###.##"/></span>
    </td>
  </tr>

  <tr class="priceWithDiscount">
    <td><g:message code="course.priceDiscount"/>:</td>
    <td>
      $ <span id="priceWithDiscount"><g:formatNumber number="${finalAmount}" format="#,###.##"/></span>
    </td>
  </tr>

  <tr class="taxIva">
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
