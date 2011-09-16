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
package com.synergyj.grain.event

import grails.util.Environment

class QueueForMailService {

  static rabbitQueue = 'myQueue'

  def mailService

  void handleMessage(Map message){
    switch(Environment.current){
      case Environment.DEVELOPMENT:
        // Que huevos!!!
        Thread.sleep(5000)
        log.debug("${Environment.current} - ${message}")
        break
      case Environment.TEST:
        log.debug("${Environment.current} - ${message}")
        break
      case Environment.PRODUCTION:
        mailService.sendMail {
          to message.to
          from message.from
          subject message.subject
          body(view:message.view,model:message.model)
        }
        break
    }
  }
}
