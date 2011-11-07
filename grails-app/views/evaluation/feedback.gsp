<%@ page import="com.synergyj.geedback.KindOfQuestion; com.synergyj.grain.course.Course" %>
<html>
<head>
  <meta name="layout" content="wb"/>
  <title><g:message code="evaluation.feedback" default="Evaluation feedback"/></title>
  <parameter name="pageHeader" value="${g.message(code: 'evaluation.feedback', default: 'Evaluation feedback')}"/>
  <script type="text/javascript" language="javascript" src="${resource(dir:'js',file:'tables.js')}"></script>
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

  </div>

</div>
</body>
</html>
