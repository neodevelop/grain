/*
 * Copyright 2002-2008 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
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
          answer = new ExtraInformationForAnswer(answerForQuestion:answerForQuestion,kindOfExtraInformation:KindOfExtraInformation.PRIVATE)
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
