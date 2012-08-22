<div id="sessionList">
  <ul>
    <g:each in="${courseSessions?.sort()}" var="courseSessionInstance">
      <li id="sessionCourse${courseSessionInstance.id}">
        <span id="sessionCourseValue${courseSessionInstance.id}">${courseSessionInstance?.encodeAsHTML()}</span>
        &nbsp;-&nbsp;
        <span id="sessionCourseEndTime${courseSessionInstance.id}">
          <g:formatDate date="${courseSessionInstance?.sessionEndTime}" format="HH:mm"/>
        </span>
        <a class="updateSession" href="${createLink(controller:'courseSession',action:'updateAsync',id:courseSessionInstance.id)}">
          Update
        </a>
        <a class="deleteSession" href="${createLink(controller:'courseSession',action:'deleteAsync',id:courseSessionInstance.id)}">
          Delete
        </a>
      </li>
    </g:each>
  </ul>
</div>