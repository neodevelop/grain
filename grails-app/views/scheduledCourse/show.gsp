<%@ page import="com.synergyj.grain.course.ScheduledCourse" %>
<html>
<head>
  <meta name="layout" content="wb" />
  <title><g:message code="scheduledCourse.show" default="Show ScheduledCourse" /></title>
  <parameter name="pageHeader" value="${g.message(code: 'scheduledCourse.show', default: 'Scheduled Course Info')}"/>
  <g:javascript>
    $(function(){
      $('#sessionStartTime').datepicker({ dateFormat:"dd/mm/yy" });

      $('#showAddCourseSession').click(function(){
        $('#newSessionCourse').show();
        $('#showAddCourseSession').hide();
      });

      $("a.deleteSession").live("click",function(){
        var splitLink = this.href.split('/')
        var index = splitLink[splitLink.length - 1];
        //alert(index);
        $.ajax({
          type:'POST',
          url:this.href,
          success:function(data){
            $("li#sessionCourse"+index).fadeOut('slow');
          },
          error:function(){
            alert("Couldn't delete session");
          }
        });

        return false;
      });
    });

    function restoreLink(){
      $('#newSessionCourse').hide();
      $('#showAddCourseSession').show();
      return false;
    }
    function reacting(e){
      var date = new Date(e.sessionStartTime)
      var stringdate = date.getDate()+"-"+(date.getMonth()+1)+"-"+date.getFullYear();
      var link = "<a class='deleteSession' id='"+e.id+"' href='${createLink(controller:'courseSession',action:'deleteAsync')}/"+e.id+"'>Delete</a>";
      $("<li id='sessionCourse"+e.id+"'>"+stringdate+" "+link+"</li>").appendTo("div#sessionList > ul");
    }
  </g:javascript>

</head>
<body>
<div class="nav">
  <span class="menuButton"><g:link class="list" action="list"><g:message code="scheduledCourse.list" default="ScheduledCourse List" /></g:link></span>
  <span class="menuButton"><g:link class="create" action="create"><g:message code="scheduledCourse.new" default="New ScheduledCourse" /></g:link></span>
</div>
<div class="body">
  <g:form style="height: 100%">
    <div class="dialog">
      <table>
        <tbody>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="scheduledCourse.id" default="Id" />:</td>

          <td valign="top" class="value">${fieldValue(bean: scheduledCourseInstance, field: "id")}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="scheduledCourse.course" default="Course" />:</td>

          <td valign="top" class="value"><g:link controller="course" action="show" id="${scheduledCourseInstance?.course?.id}">${scheduledCourseInstance?.course?.encodeAsHTML()}</g:link></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="scheduledCourse.costByCourse" default="Cost By Course" />:</td>

          <td valign="top" class="value">$ <g:formatNumber number="${scheduledCourseInstance?.costByCourse}" format="#,##0.00;(#,##0.00)" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="scheduledCourse.costByModule" default="Cost By Module" />:</td>

          <td valign="top" class="value">$ <g:formatNumber number="${scheduledCourseInstance?.costByModule}" format="#,##0.00;(#,##0.00)" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="scheduledCourse.beginDate" default="Begin Date" />:</td>

          <td valign="top" class="value"><g:formatDate date="${scheduledCourseInstance?.beginDate}" format="dd-MMMM-yy" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="scheduledCourse.limitRegistrationDate" default="Limit Registration Date" />:</td>

          <td valign="top" class="value"><g:formatDate date="${scheduledCourseInstance?.limitRegistrationDate}" format="dd-MMMM-yy" /></td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="scheduledCourse.status" default="Status:" />:</td>

          <td valign="top" class="value">${scheduledCourseInstance.scheduledCourseStatus}</td>

        </tr>

        <tr class="prop">
          <td valign="top" class="name"><g:message code="scheduledCourse.courseSessions" default="Course Sessions" />:</td>

          <td  valign="top" style="text-align: left;" class="value">
            <div id="sessionList">
            <ul>
              <g:each in="${scheduledCourseInstance?.courseSessions}" var="courseSessionInstance">
                <li id="sessionCourse${courseSessionInstance.id}">
                  ${courseSessionInstance?.encodeAsHTML()}
                  <a class="deleteSession" href="${createLink(controller:'courseSession',action:'deleteAsync',id:courseSessionInstance.id)}">
                    Delete
                  </a>
                </li>
              </g:each>
            </ul>
            </div>
          </td>

        </tr>

        </tbody>
      </table>


    </div>
    <g:hiddenField name="id" value="${scheduledCourseInstance?.id}" />
    <div class="buttons">
      <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
      <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
    </div>
  </g:form>
</div>
<br/>
<button id="showAddCourseSession">
  <g:message code="scheduledCourse.addSessions" default="Add Session" />
</button>

<div id="newSessionCourse" title="Add a new session" style="display:none;">
  <g:formRemote
      name="addSessionToScheduledCourse"
      url="[controller:'scheduledCourse',action:'newSessionToCourse']"
      onSuccess="reacting(data)"
      onComplete="restoreLink()" style="height:100%;" >
    <g:hiddenField name="scheduledCourseId" value="${scheduledCourseInstance.id}"/>
    Fecha de la Sessión: <g:textField name="sessionStartTime" />
    <input type="submit" value="Add Session to Course" id="addSession" name="addSession"/>
  </g:formRemote>
</div>

</body>
</html>
