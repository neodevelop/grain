<table class="expensesList" cellpadding="5px" cellspacing="0" width="100%">
  <thead>
    <tr>
      <th>#</th>
      <th>Expense Time</th>
      <th>Category</th>
      <th>Description</th>
      <th align="right">Amount</th>
    </tr>
  </thead>
  <tbody>
    <g:set var="totalExpenseCost" value="${new BigDecimal(0)}"/>
    <g:each in="${expensesList}" var="expense" status="i">
    <tr>
      <td>${i + 1}</td>
      <td align="center"><g:formatDate date="${expense.expenseTime}" format="dd/MM/yyyy hh:mm"/></td>
      <td>${expense.expenseCategory}</td>
      <td>${expense.description}</td>
      <td align="right">$ <g:formatNumber number="${expense.amount}" format="#,###.00" locale="MX"/> </td>
      <g:set var="totalExpenseCost" value="${totalExpenseCost + expense.amount}"/>
    </tr>
    </g:each>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="5" align="center">
        <b>Total de costos:</b>
        <b>$ <g:formatNumber number="${totalExpenseCost}" format="#,###.00" locale="MX"/></b>
      </td>
    </tr>
  </tfoot>
</table>