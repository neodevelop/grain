<div class="dialog">
  <table>
    <tbody>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="amount"><g:message code="expense.amount" default="Amount"/>:</label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'amount', 'errors')}">
        <g:textField name="amount" value="${fieldValue(bean: expenseInstance, field: 'amount')}"/>

      </td>
    </tr>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="description"><g:message code="expense.description" default="Description"/>:</label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'description', 'errors')}">
        <g:textField name="description" value="${fieldValue(bean: expenseInstance, field: 'description')}"/>

      </td>
    </tr>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="expenseCategory"><g:message code="expense.expenseCategory" default="Expense Category"/>:</label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'expenseCategory', 'errors')}">
        <g:select name="expenseCategory" from="${com.synergyj.grain.course.ExpenseCategory?.values()}"
                  value="${expenseInstance?.expenseCategory}"/>

      </td>
    </tr>

    <tr class="prop">
      <td valign="top" class="name">
        <label for="expenseTime"><g:message code="expense.expenseTime" default="Expense Time"/>:</label>
      </td>
      <td valign="top" class="value ${hasErrors(bean: expenseInstance, field: 'expenseTime', 'errors')}">
        <g:datePicker name="expenseTime" value="${expenseInstance?.expenseTime}"/>

      </td>
    </tr>

    </tbody>
  </table>
</div>