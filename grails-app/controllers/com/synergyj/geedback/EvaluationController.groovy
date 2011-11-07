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

  @Secured(['ROLE_ADMIN'])
  def feedback = {
    def scheduledCourse = ScheduledCourse.withCriteria(uniqueResult: true) {
      eq 'id', params.long('id')
      join "course"
    }
    def evaluations = Evaluation.withCriteria {
      eq 'scheduledCourse', scheduledCourse
    }
    def questionnarie = Questionnaire.withCriteria(uniqueResult: true) {
      eq 'id', 1L
      fetchMode 'questions', FM.EAGER
    }
    [scheduledCourse: scheduledCourse, evaluations: evaluations,questionnarie:questionnarie,questionnarie:questionnarie]
  }
}
