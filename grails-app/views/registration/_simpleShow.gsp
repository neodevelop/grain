  <h4>Course:</h4>
  <h3>${registration.scheduledCourse.course}</h3>
  <br>
  <h4>Registration on:</h4>
  <h3><g:formatDate date="${registration.dateCreated}" format="EEEE dd-MMMM-yyyy"/></h3>
  <br>
  <h4>Original Price:</h4>
  <h3>
    $ ${registration.scheduledCourse.costByCourse}
  </h3>
  <g:if test="${discount}">
  <div id="discount">
    <h4>Discount:</h4>
    <h3>
      - $ ${discount}
    </h3>
  </div>
  <div id="priceWithDiscount">
    <h4>Price with discount:</h4>
    <h3>
      $ ${finalAmount}
    </h3>
  </div>
  </g:if>
  <g:if test="${iva}">
  <div id="invoice">
    <h5>IVA: $ <span id="IVA">${iva}</span></h5>
  </div>
  </g:if>
  <h2>Final price:</h2>
  <h1>
    <g:if test="${finalAmountWithTax}">
      $ ${finalAmountWithTax}
      <g:hiddenField name="totalAmount" value="${finalAmountWithTax}"/>
    </g:if>
    <g:else>
      $ ${registration.scheduledCourse.costByCourse}
      <g:hiddenField name="totalAmount" value="${registration.scheduledCourse.costByCourse}"/>
    </g:else>
  </h1>
  <br/><br/>
  <div id="paymentConfirmation">

  </div>