<g:set var="totalAmountPerGroup" value="${new BigDecimal(0)}"/>
<g:set var="totalCommissionPerGroup" value="${new BigDecimal(0)}"/>
<g:each in="${registrationGroup}" var="registration">
  <g:each in="${registration?.payments}" var="payment">
    <g:set var="totalAmountPerGroup" value="${totalAmountPerGroup + payment.amount}"/>
    <g:set var="totalCommissionPerGroup" value="${totalCommissionPerGroup?.plus(payment?.commission ?: 0)}"/>
  </g:each>
</g:each>

<g:set var="totalExpenseCost" value="${new BigDecimal(0)}"/>
<g:each in="${expensesList}" var="expense">
  <g:set var="totalExpenseCost" value="${totalExpenseCost + expense.amount}"/>
</g:each>

<table class="summary" cellpadding="5px" cellspacing="0" width="100%">
  <thead>
  <tr>
    <th>Concepto</th>
    <th>Subtotal</th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td>
      Ingreso bruto
      <i>(Total que entró a cuenta bancaria)</i>
    </td>
    <td align="right">
      $ <g:formatNumber number="${totalAmountPerGroup}" format="#,###.00" locale="MX"/>
    </td>
  </tr>
  <tr>
    <td>
      Comisiones de manejo de dinero
      <i>(Costo del manejo de dinero por pago con TC o Efectivo aplicada por DM)</i>
    </td>
    <td align="right">
      - $ <g:formatNumber number="${totalCommissionPerGroup}" format="#,###.00" locale="MX"/>
    </td>
  </tr>
  <tr>
    <td>
      Gastos de operación e impuestos
      (Logística e impuestos)
    </td>
    <td align="right">
      - $ <g:formatNumber number="${totalExpenseCost}" format="#,###.00" locale="MX"/>
    </td>
  </tr>
  </tbody>
  <tfoot>
  <tr>
    <td align="right"><b>Total</b></td>
    <td align="right"><b>${totalAmountPerGroup - totalCommissionPerGroup - totalExpenseCost}</b></td>
  </tr>
  </tfoot>
</table>