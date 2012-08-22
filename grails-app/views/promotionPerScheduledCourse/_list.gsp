<table id="promotionsList" class="table table-condensed">
  <thead>
    <tr>
      <th>#</th>
      <th>Promocion</th>
      <th>Vigencia</th>
      <th>Tipo</th>
      <th>Descuento</th>
    </tr>
  </thead>
  <tbody>
    <g:each in="${promotions}" var="promotionForThisScheduledCourse" status="i">
    <tr>
      <td>${i+1}</td>
      <td>${promotionForThisScheduledCourse.promotion}</td>
      <td><g:formatDate date="${promotionForThisScheduledCourse.validUntil}" format="dd-MMMM-yy" /></td>
      <td>${promotionForThisScheduledCourse.promotion.discount} %</td>
      <td>${promotionForThisScheduledCourse.promotion.kindPromotion}</td>
    </tr>
    </g:each>
  </tbody>
</table>