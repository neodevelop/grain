package com.synergyj.geedback

class EvaluationService {

  static transactional = false

  def checkIfThisUserHasEvaluationToThisCourse(Long scheduledCourseId, String email) {
    def criteria = Evaluation.createCriteria()
    def evaluationCount = criteria.count {
      user {
        eq "email", email
      }
      scheduledCourse {
        eq "id", scheduledCourseId
      }
      eq "evaluationStatus",EvaluationStatus.CLOSED
    }
    evaluationCount
  }
  
  def saveOptionForThisQuestion(Long evaluationId,Long questionId, def answerId, kindOfQuestion = KindOfQuestion.CHOOSE_OPTION){
    log.debug "Obteniendo evaluación"
    def evaluation = Evaluation.get(evaluationId)
    log.debug "Obteniendo pregunta de evaluación"
    def question = Question.get(questionId)
    log.debug "Buscamos si ya tiene una respuesta a esa pregunta"
    def answerForQuestion = AnswerForQuestion.findByEvaluationAndQuestion(evaluation,question)
    log.debug "Si no la tiene entonces creamos una"
    if(!answerForQuestion)
      answerForQuestion = new AnswerForQuestion(evaluation:evaluation,question:question)
    log.debug "Validando el tipo de pregunta"
    switch(kindOfQuestion){
      case [KindOfQuestion.CHOOSE_OPTION,KindOfQuestion.TRUE_FALSE]:
        log.debug "La pregunta es de opción a escoger"
        log.debug "Obtenemos la opción que escogió"
        def answer = OptionQuestion.get(answerId)
        log.debug "Asignamos la respuesta"
        answerForQuestion.optionQuestion = answer        
        break
      case [KindOfQuestion.SHORT_ANSWER,KindOfQuestion.DESCRIPTION]:
        log.debug "La pregunta es abierta"
        log.debug "Buscamos si ya tiene una respuesta a esta pregunta"
        def answer = null
        if(answerForQuestion.id){
          answer = ExtraInformationForAnswer.findByAnswerForQuestion(answerForQuestion)
        }
        if(!answer){
          answer = new ExtraInformationForAnswer(answerForQuestion:answerForQuestion,kindOfExtraInformation:KindOfExtraInformation.PUBLIC_THIS)
          answerForQuestion.addToExtras(answer)
        }
        answer.description = answerId
        break
      default:
        log.debug "El tipo de pregunta no es válido hasta el momento"
        break
    }
    log.debug "Guardamos la respuesta"
    answerForQuestion.save()
    answerForQuestion
  }
}
