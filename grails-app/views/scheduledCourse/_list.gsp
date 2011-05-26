<div class="list">
  <table id="scheduludeCourseList" cellpadding="5" cellspacing="0" border="0" width="100%">
    <thead>
    <tr>

      <th width="30%"><g:message code="scheduledCourse.course" default="Course" /></th>

      <g:sortableColumn property="beginDate" title="Begin Date" titleKey="scheduledCourse.beginDate" />

      <g:sortableColumn property="limitRegistrationDate" title="Limit Registration Date" titleKey="scheduledCourse.limitRegistrationDate" />

      <g:sortableColumn property="costByCourse" title="Cost By Course" titleKey="scheduledCourse.costByCourse" />

      <sec:ifAllGranted roles="ROLE_USER">
        <sec:ifNotGranted roles="ROLE_ADMIN">
          <th>&nbsp;</th>
        </sec:ifNotGranted>
      </sec:ifAllGranted>

    </tr>
    </thead>
    <tbody>
    <g:each in="${scheduledCourseList}" status="i" var="scheduledCourse">
      <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">

        <td>
          <sec:ifAllGranted roles="ROLE_ADMIN">
            <g:link controller="scheduledCourse" action="show" id="${scheduledCourse.id}">
              ${fieldValue(bean: scheduledCourse, field: "course")}
            </g:link>
          </sec:ifAllGranted>

          <sec:ifAllGranted roles="ROLE_USER">
            <sec:ifNotGranted roles="ROLE_ADMIN">
              <!-- TODO: Mostrar el detalle del curso(temario) -->
              ${fieldValue(bean: scheduledCourse, field: "course")}
            </sec:ifNotGranted>
          </sec:ifAllGranted>

        </td>

        <td><g:formatDate date="${scheduledCourse.beginDate}" format="dd-MMMM-yy" /></td>

        <td><g:formatDate date="${scheduledCourse.limitRegistrationDate}" format="dd-MMMM-yy" /></td>

        <td>$ <g:formatNumber number="${scheduledCourse.costByCourse}" format="#,##0.00;(#,##0.00)" /></td>

        <sec:ifAllGranted roles="ROLE_USER">
          <sec:ifNotGranted roles="ROLE_ADMIN">
            <th>
              <div id="registration${i}">
                <g:remoteLink action="addMeToCourse" controller="registration" id="${scheduledCourse.id}" onSuccess="registered(data,${i})">
                  <g:message code="registration.register" default="Register here..." />
                </g:remoteLink>
                <g:javascript>
                  function registered(registration,index){
                    $("div#registration"+index +" > a").hide();
                    if(registration.message){
                      $("<span id='fail"+index+"'>"+registration.message+"</span>").appendTo("div#registration"+index);
                    }else{
                      $("<span id='ok"+index+"'>${message(code:'registration.ok',default:'Haz quedado registrado!!!')}</span>").appendTo("div#registration"+index);
                    }
                  }
                </g:javascript>
              </div>
            </th>
          </sec:ifNotGranted>
        </sec:ifAllGranted>

      </tr>
    </g:each>
    </tbody>
  </table>
</div>