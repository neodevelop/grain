  <h4>Course:</h4>
  <h3>${registration.scheduledCourse.course}</h3>
  <br>
  <h4>Registration on:</h4>
  <h3><g:formatDate date="${registration.dateCreated}" format="EEEE dd-MMMM-yyyy"/></h3>
  <br>

  <table id="breakDownDetail">
    <tr>
      <td>Original Price:</td>
      <td>$ <g:formatNumber number="${registration.scheduledCourse.costByCourse}" format="#,###.##"/></td>
    </tr>

    <g:if test="${discount}">
      <tr class="discount">
        <td>Discount:</td>
        <td>
          - $ <g:formatNumber number="${discount}" format="#,###.##"/>
        </td>
      </tr>
      <tr class="priceWithDiscount">
        <td>Price with discount:</td>
        <td>
          $ <g:formatNumber number="${finalAmount}" format="#,###.##"/>
        </td>
      </tr>
    </g:if>

    <g:if test="${iva}">

    <tr class="taxIva">
      <td>IVA:</td>
      <td>$ <g:formatNumber number="${iva}" format="#,###.##"/></td>
    </tr>
    </g:if>

    <tr class="finalPrice">
      <td>Final price:</td>
      <td class="finalAmount">
        <g:if test="${finalAmountWithTax}">
          $ <g:formatNumber number="${finalAmountWithTax}" format="#,###.##"/>
        </g:if>
        <g:else>
          $ <g:formatNumber number="${registration.scheduledCourse.costByCourse}" format="#,###.##"/>
        </g:else>
      </td>
    </tr>
  </table>
