<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
  <meta name="layout" content="wb" />
  <title><g:message code="calendar.show" default="Show Calendar" /></title>
  <link rel='stylesheet' type='text/css' href='http://arshaw.com/js/fullcalendar-1.5.1/fullcalendar/fullcalendar.css' />
  <link rel='stylesheet' type='text/css' href='http://arshaw.com/js/fullcalendar-1.5.1/fullcalendar/fullcalendar.print.css' media='print' />
  <script type='text/javascript' src='http://arshaw.com/js/fullcalendar-1.5.1/fullcalendar/fullcalendar.min.js'></script>
  <parameter name="pageHeader" value="${g.message(code: 'calendar.show', default: 'Calendar')}"/>
  <g:javascript>
    $(function(){
      var date = new Date();
      var d = date.getDate();
      var m = date.getMonth();
      var y = date.getFullYear();

      $('#calendar').fullCalendar({
        theme: true,
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'month,agendaWeek,agendaDay'
        },
        monthNames:['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
        editable: true,
        events: [
          {
            title: 'All Day Event',
            start: new Date(y, m, 1)
          },
          {
            title: 'Long Event',
            start: new Date(y, m, d-5),
            end: new Date(y, m, d-2)
          },
          {
            id: 999,
            title: 'Repeating Event',
            start: new Date(y, m, d-3, 16, 0),
            allDay: false
          },
          {
            id: 999,
            title: 'Repeating Event',
            start: new Date(y, m, d+4, 16, 0),
            allDay: false
          },
          {
            title: 'Meeting',
            start: new Date(y, m, d, 10, 30),
            allDay: false
          },
          {
            title: 'Lunch',
            start: new Date(y, m, d, 12, 0),
            end: new Date(y, m, d, 14, 0),
            allDay: false
          },
          {
            title: 'Birthday Party',
            start: new Date(y, m, d+1, 19, 0),
            end: new Date(y, m, d+1, 22, 30),
            allDay: false
          },
          {
            title: 'Click for Google',
            start: new Date(y, m, 28),
            end: new Date(y, m, 29),
            url: 'http://google.com/',
            color:'green'
          }
        ]
      });
    });
  </g:javascript>
</head>
<body>
<div id='calendar'></div>
</body>
</html>