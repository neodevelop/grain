<div id="newExpense" title="Add a new expense" class="modal hide">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal">×</button>
    <h3>Add expense to this course</h3>
  </div>
  <div class="modal-body">
  <g:formRemote
      name="addExpenseToScheduledCourse"
      url="[controller:'expense',action:'addToScheduledCourse']"
      onSuccess="addExpenseToTable(data)"
      onComplete="restoreForm()" class="form-horizontal" >
    <fieldset>
    <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
    <g:hiddenField name="expenseId" value="0"/>
    <g:render template="/expense/form" model="[expenseInstance:expenseInstance]"/>
    </fieldset>
  </g:formRemote>
  </div>
  <div class="modal-footer">
    <a href="#" id="addExpense" class="btn btn-primary">Add Expense to Course</a>
    <a href="#" class="btn" data-dismiss="modal">Cerrar</a>
  </div>
</div>