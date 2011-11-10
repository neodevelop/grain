package com.synergyj.geedback

import com.synergyj.grain.course.ScheduledCourse
import org.hibernate.FetchMode as FM
import grails.converters.JSON
import grails.plugins.springsecurity.Secured

class EvaluationController {

  def springSecurityService
  def evaluationService

  @Secured(['isAuthenticated()'])
  def index = {
    def scheduledCourse = ScheduledCourse.get(params.id)
    def user = springSecurityService.currentUser
    // TODO: Asignar un cuestionario por curso calendarizado
    def quiz = Questionnaire.withCriteria(uniqueResult: true) {
      eq 'id', 1L
      fetchMode "questions", FM.EAGER
    }
    def evaluation = Evaluation.findByScheduledCourseAndUser(scheduledCourse, user)
    if (!evaluation) {
      evaluation = new Evaluation(user: user, evaluationStatus: EvaluationStatus.OPEN)
      evaluation.questionnaire = quiz
      scheduledCourse.addToEvaluations(evaluation)
      scheduledCourse.save()
    }

    [quiz: quiz, evaluation: evaluation]
  }

  def pickAnswer = {
    log.debug params
    def answerForQuestion = evaluationService.saveOptionForThisQuestion(
      params.long('evaluationId'),
      params.long('questionId'),
      params."answerFor${params.questionId}",
      KindOfQuestion.valueOf(params.kindOfQuestion)
    )
    render answerForQuestion as JSON
  }

  def confirm = {
    def evaluation = Evaluation.get(params.id)
    evaluation.evaluationStatus = EvaluationStatus.CLOSED
    flash.message = "Gracias por contestar nuestra evaluación del curso..."
    redirect(uri: '/me')
  }

  def reset = {
    def evaluation = Evaluation.get(params.id)
    evaluation.evaluationStatus = EvaluationStatus.OPEN
    render "Status: ${evaluation.evaluationStatus }"
  }

  @Secured(['ROLE_ADMIN'])
  def feedback = {
    // Obtenemos el curso calendarizado con su curso
    def scheduledCourse = ScheduledCourse.withCriteria(uniqueResult: true) {
      eq 'id', params.long('id')
      join "course"
    }
    // Obtenemos las evaluaciones por curso
    def evaluations = Evaluation.withCriteria {
      eq 'scheduledCourse', scheduledCourse
    }
    // Obtenemos el cuestionario realizado con sus preguntas
    def questionnarie = Questionnaire.withCriteria(uniqueResult: true) {
      eq 'id', 1L
      fetchMode 'questions', FM.EAGER
    }
    
    // Preparando la cuenta
    def dataGraph = [:]
    // Iteramos las evaluaciones
    evaluations.each{ evaluation ->
      // Iteramos las respuestas de cada evaluación
      evaluation.answers.sort().each{ answer ->
        // Solo se toman en cuenta evaluaciones de opcion multiple
        if((answer.question.kindOfQuestion == KindOfQuestion.CHOOSE_OPTION) || (answer.question.kindOfQuestion == KindOfQuestion.TRUE_FALSE)){
          // Si no tenemos el elemento en el mapa lo creamos
          if(!(dataGraph[answer.question])){
            dataGraph[answer.question] = [:]
            def currentQuestion = questionnarie.questions.find { it == answer.question }
            currentQuestion.options.sort().each{ option ->
              dataGraph[answer.question][option] = 0
            }
            
          }
          // Si dentro del mapa de respuestaa no esta la opcion, entonces la agregamos
          if(!(dataGraph[answer.question][answer.optionQuestion])){
            dataGraph[answer.question][answer.optionQuestion] = 0
          }
          // Sumamos uno a la respuesta escogida de la respuesta
          dataGraph[answer.question][answer.optionQuestion] += 1
        }
      }
    }
    
    log.debug dataGraph
    
    [scheduledCourse: scheduledCourse, evaluations: evaluations,questionnarie:questionnarie,dataGraph:dataGraph]
  }
}
