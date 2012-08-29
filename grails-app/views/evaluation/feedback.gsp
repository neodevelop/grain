<%@ page import="com.synergyj.geedback.KindOfQuestion; com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="mainContent"/>
  <title><g:message code="evaluation.feedback" default="Evaluation feedback"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'evaluation.feedback', default: 'Evaluation feedback')}"/>
  <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'tables.js')}"></script>
  <script language="javascript" type="text/javascript" src="https://bitbucket.org/cleonello/jqplot/raw/71df38b4d45a/src/jquery.jqplot.js"></script>
  
  <script type="text/javascript" src="https://bitbucket.org/cleonello/jqplot/raw/71df38b4d45a/src/plugins/jqplot.dateAxisRenderer.js"></script>
  <script type="text/javascript" src="https://bitbucket.org/cleonello/jqplot/raw/71df38b4d45a/src/plugins/jqplot.canvasTextRenderer.js"></script>
  <script type="text/javascript" src="https://bitbucket.org/cleonello/jqplot/raw/71df38b4d45a/src/plugins/jqplot.canvasAxisTickRenderer.js"></script>
  <script type="text/javascript" src="https://bitbucket.org/cleonello/jqplot/raw/71df38b4d45a/src/plugins/jqplot.categoryAxisRenderer.js"></script>
  <script type="text/javascript" src="https://bitbucket.org/cleonello/jqplot/raw/71df38b4d45a/src/plugins/jqplot.barRenderer.js"></script>
  
  <link rel="stylesheet" type="text/css" href="https://bitbucket.org/cleonello/jqplot/raw/71df38b4d45a/src/jquery.jqplot.css" />
  <script type="text/javascript" language="javascript">
    $(function() {
      $("div#tabs").tabs();
      $("table.answers").styleTable();
      $("a.reset").button();
    });
  </script>
</head>

<body>
<div class="content">
  <h3>${scheduledCourse.course}</h3>

  <div id="tabs" style="width:100%;">

    <ul>
      <g:each in="${evaluations}" var="evaluation" status="i">
        <li><a href="#tabs-${i}">${evaluation.user.email}</a></li>
      </g:each>
        <li><a href="#tabs-summary">Summary</a></li>
    </ul>

    <g:each in="${evaluations}" var="evaluation" status="i">
      <div id="tabs-${i}">
        <table class="answers" cellpadding="5" cellspacing="0">
          <thead>
            <tr>
              <th>#</th>
              <th>Pregunta</th>
              <th>Respuesta</th>
            </tr>
          </thead>
          <tbody>
            <g:each in="${questionnarie.questions.sort()}" var="question" status="j">
            <tr>
              <td>${j+1}</td>
              <td>${question}</td>
              <td>
                <g:findAll in="${evaluation.answers}" expr="it.question.id == question.id">
                  <g:if test="${it.question.kindOfQuestion == KindOfQuestion.CHOOSE_OPTION || it.question.kindOfQuestion == KindOfQuestion.TRUE_FALSE}">
                    <b>${it.optionQuestion}</b>
                  </g:if>
                  <g:if test="${it.question.kindOfQuestion == KindOfQuestion.SHORT_ANSWER || it.question.kindOfQuestion == KindOfQuestion.DESCRIPTION}">
                    <g:set var="extras" value="${it.extras}"/>
                    <g:each in="${extras}" var="extra">
                      <b>${extra.description}</b>
                    </g:each>
                  </g:if>
                </g:findAll>
              </td>
            </tr>
            </g:each>
          </tbody>
        </table>
        <br/>
        <div align="center">
          <g:remoteLink controller="evaluation" action="reset" id="${evaluation.id}" class="reset" update="evaluationStatus${evaluation.id}">
            Restablecer evaluación
          </g:remoteLink>
          <div id="evaluationStatus${evaluation.id}">
            Status: ${evaluation.evaluationStatus}
          </div>
        </div>
      </div>
    </g:each>
    <div id="tabs-summary">
      <div align="center">
        <h3>Summary</h3>
      </div>
      <table>
      <g:each in="${dataGraph.sort()}" var="question" status="i">
        <g:if test="${(i%3) == 0}">
        <tr>
        </g:if>
        <td>
          <div id="chart${i}" style="height:200px;width:300px; ">
          </div>
        </td>
        <g:if test="${(i%3) == 2}">
        </tr>
        </g:if>
      </g:each>
      </table>
        
      <g:each in="${dataGraph.sort()}" var="question" status="i">
        <script type="text/javascript" language="javascript">
          var data${i} = [
            <g:each in="${question.value}">
              ["${(it.key.toString().size() <= 18) ? it.key.toString()  : it.key.toString().substring(0,15) }",${it.value}],
            </g:each>
            ['',0]
          ];
          data${i}.pop();
          var plot${i} = $.jqplot('chart${i}',[data${i}], {
            title:{
              text:'${question.key}',
              fontSize:'14px'
            },
            series:[{renderer:$.jqplot.BarRenderer}],
            axesDefaults: {
              tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
              tickOptions: {
                angle: -30,
                fontSize: '10pt'
              }
            },
            axes: {
              xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer
              }
            }
          });
        </script>
        
      </g:each>
      
    </div>
  </div>

</div>
</body>
</html>
