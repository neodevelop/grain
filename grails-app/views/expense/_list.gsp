<table id="expenseList" class="table table-condensed">
  <thead>
    <tr>
      <th>#</th>
      <th>Description</th>
      <th>Category</th>
      <th>Time</th>
      <th>Amount</th>
    </tr>
  </thead>
  <tbody>
    <tr class="expense" style="display:none;">
      <td><span class="expenseId"></span></td>
      <td><span class="description"></span></td>
      <td><span class="expenseCategory"></span></td>
      <td><span class="expenseTime"></span></td>
      <td><span class="amount"></span></td>
    </tr>
    <g:set var="totalExpenses" value="${new BigDecimal(0)}" />
    <g:each in="${expenses?.sort()}" var="expenseInstance" status="i">
    <tr id="expense${expenseInstance.id}">
      <td>${i+1}</td>
      <td>
        <g:link controller="expense" action="show" id="${expenseInstance.id}">
          ${expenseInstance.description}
        </g:link>
      </td>
      <td>${expenseInstance.expenseCategory}</td>
      <td><g:formatDate date="${expenseInstance.expenseTime}" format="dd/MM/yyyy HH:mm"/></td>
      <td align="right">
        $ <g:formatNumber number="${expenseInstance.amount}" locale="MX" format="#,###.00"/>
      </td>
    </tr>
    <g:set var="totalExpenses" value="${totalExpenses + expenseInstance.amount}" />
    </g:each>
    <tfoot>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td align="right">
          <b>Total</b>
        </td>
        <td align="right">
          <b>$ <g:formatNumber number="${totalExpenses}" locale="MX" format="#,###.00"/></b>
        </td>
      </tr>
    </tfoot>
  </tbody>
</table>