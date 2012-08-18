<div class="control-group">
  <label class="control-label" for="amount"><g:message code="expense.amount" default="Amount"/>:</label>
  <div class="input-prepend input-append">
    <span class="add-on">$</span><g:textField name="amount" value="${fieldValue(bean: expenseInstance, field: 'amount')}" class="input-small"/>
  </div>
</div>

<div class="control-group">
  <label class="control-label" for="description"><g:message code="expense.description" default="Description"/>:</label>
  <g:textField name="description" value="${fieldValue(bean: expenseInstance, field: 'description')}"/>
</div>

<div class="control-group">
  <label class="control-label" for="expenseCategory"><g:message code="expense.expenseCategory" default="Expense Category"/>:</label>
  <g:select name="expenseCategory" from="${com.synergyj.grain.course.ExpenseCategory?.values()}"
            value="${expenseInstance?.expenseCategory}" />
</div>

<div class="control-group">
  <label class="control-label" for="expenseTime"><g:message code="expense.expenseTime" default="Expense Time"/>:</label>
  <g:datePicker name="expenseTime" value="${expenseInstance?.expenseTime}" class="span1"/>
</div>
<r:script>
  $("select[id^=expenseTime]").addClass("span1");
</r:script>
