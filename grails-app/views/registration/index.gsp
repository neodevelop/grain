<html>
  <head>
    <title>Registration</title>
    <g:javascript library="jquery" plugin="jquery"/>
  </head>
  <body>
  <h1>Lista de cursos disponibles</h1>
  <g:render template="/scheduledCourse/list" model="[scheduledCourseList:scheduledCoursesForRegistration]"/>
  </body>
</html>