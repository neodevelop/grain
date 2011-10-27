<%@ page import="com.synergyj.geedback.KindOfQuestion;" %>
<head>
  <title><g:message code='evaluation.action' default="Evaluate this course"/></title>
  <meta name='layout' content='wb'/>
  <parameter name="pageHeader" value="${g.message(code: 'evaluation.action', default: 'Evaluate this course')}"/>
  <script type="text/javascript" language="javascript">
  $(function() {
    $("#accordion").accordion({autoHeight: false,navigation: true});
    $("button").button();
    $("#accordion > h3").hide();
    $("div[id^=question]").hide();
    $("#accordion > h3").first().fadeIn();
    $("div[id^=question]").first().fadeIn();
    
    $("input[name^=answerFor]").click(function(){
      var questionId = $(this).attr('name').substring("answerFor".length);
      $(this).parent().parent().next().fadeIn();
      $("form#formQuestion"+questionId).submit();
      $("span#quizCursor").text(questionId);
    });
    
    $("button[name^=actionForQuestion]").click(function(){
      var questionId = $(this).attr("name").substring("actionForQuestion".length);
      $(this).parent().parent().next().fadeIn();
      $("form#formQuestion"+questionId).submit();
      $("span#quizCursor").text(questionId);
      $(this).text("Actualizar");
    });
        
  });
  
  function waiting(id){
    $("img#loader"+id).fadeIn();
    $("img#check"+id).hide();
  }

  function complete(id){
    $("img#loader"+id).hide();
    $("img#check"+id).fadeIn();
  }
  
  function success(data){
    if( (data.question.id / 1) == ( ( $("#quizTotal").text() ) / 1) ){
      $("#statusAction").addClass("complete");
      $("#statusAction").removeClass("incomplete");
      $("#counter").hide();
      $("#finalAction").fadeIn();
    }
  }
    
  </script>
</head>
<body>

  <div id="accordion">
  <g:each in="${quiz.questions.sort()}" var="question" status="i">
    
    <h3>
      <a href="#">
        ${question} 
        <img id="loader${question.id}" style="display:none;" src="${resource(dir:'themes/wb/images',file:'ajax-loader-q.gif')}"/>
        <img id="check${question.id}" style="display:none;" src="${resource(dir:'themes/wb/icon',file:'valid-blue.png')}" width="20" height="20"/>
      </a>
    </h3>
    <div id="question${question.id}">
      <g:formRemote name="formQuestion${question.id}" url="[controller:'evaluation',action:'pickAnswer']" onLoading="waiting(${question.id})" onComplete="complete(${question.id})" onSuccess="success(data)">
        <g:hiddenField name="evaluationId" value="${evaluation.id}" />
        <g:hiddenField name="questionId" value="${question.id}" />
        <g:hiddenField name="kindOfQuestion" value="${question?.kindOfQuestion}" />
        <g:if test="${question?.kindOfQuestion == KindOfQuestion.TRUE_FALSE || question?.kindOfQuestion == KindOfQuestion.CHOOSE_OPTION}">
          <g:radioGroup id="answerFor${question.id}" name="answerFor${question.id}" labels="${question?.options?.sort()}" values="${(question?.options?.sort())*.id}">
            ${it.radio} ${it.label} <br/>
          </g:radioGroup>
        </g:if>
        <g:if test="${question?.kindOfQuestion == KindOfQuestion.SHORT_ANSWER || question?.kindOfQuestion == KindOfQuestion.DESCRIPTION}">
          <g:textArea id="answerFor${question.id}" name="answerFor${question.id}" rows="3" cols="80" value=""/>
          <br/>
          <button type="button" id="actionForQuestion${question.id}" name="actionForQuestion${question.id}">
            Continuar
          </button>
        </g:if>
      </g:formRemote>
    </div>
    
  </g:each>
  </div>
  <br/>
  <div id="statusAction" class="incomplete">
    <div id="finalAction" style="display:none;">
      <g:link controller="evaluation" action="confirm" id="${evaluation.id}">
        He terminado mi evaluación
      </g:link>
    </div>
    <div id="counter">
      <span id="quizCursor">0</span> de <span id="quizTotal">${quiz.questions.size()}</span>
    </div>
  </div>
  
</body>
