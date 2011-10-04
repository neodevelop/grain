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
import org.codehaus.groovy.grails.commons.GrailsResourceUtils
import org.codehaus.groovy.grails.web.servlet.DefaultGrailsApplicationAttributes
import grails.util.GrailsWebUtil
import org.springframework.web.context.support.WebApplicationContextUtils
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.springframework.web.context.request.RequestContextHolder
import javax.servlet.http.HttpServletRequest

class QueueForMailService {

  static transactional = true

  static rabbitQueue = NotificationService.MAIL_QUEUE_NOTIFICATION

  static throwExceptions = false

  static PATH_TO_MAILVIEWS = "/WEB-INF/grails-app/views"

  def mailService

  def groovyPagesTemplateEngine

  void handleMessage(Map message) {
    switch (Environment.current) {
      case Environment.DEVELOPMENT:
        try {

          def engine = groovyPagesTemplateEngine
          def templateName = message.view
          def requestAttributes = RequestContextHolder.getRequestAttributes()
          boolean unbindRequest = false

          // outside of an executing request, establish a mock version
          if (!requestAttributes) {
            def servletContext = ServletContextHolder.getServletContext()
            def applicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext)
            requestAttributes = GrailsWebUtil.bindMockWebRequest(applicationContext)
            unbindRequest = true
          }
          def servletContext = requestAttributes.request.servletContext
          def request = requestAttributes.request

          def grailsAttributes = new DefaultGrailsApplicationAttributes(servletContext);
          // See if the application has the view for it
          def uri = getMailViewUri(templateName, request)

          def r = engine.getResourceForUri(uri)
          def t = engine.createTemplate(r)

          def out = new StringWriter();
          def originalOut = requestAttributes.getOut()
          requestAttributes.setOut(out)

          if (message.model instanceof Map) {
            t.make(message.model).writeTo(out)
          }
          else {
            t.make().writeTo(out)
          }

          requestAttributes.setOut(originalOut)
          if (unbindRequest) {
            RequestContextHolder.setRequestAttributes(null)
          }

          log.debug("${Environment.current} - ${out}")
        } catch (Exception e) {
          log.error e.message
        }
        break
      case Environment.TEST:
        log.debug("${Environment.current} - ${message}")
        break
      case Environment.PRODUCTION:
        try {
          mailService.sendMail {
            to message.to
            from message.from
            subject message.subject
            body(view: message.view, model: message.model)
          }
        } catch (Exception e) {
          log.error e.message
        }
        break
    }
  }

  protected String getMailViewUri(String viewName, HttpServletRequest request) {

    def buf = new StringBuilder(PATH_TO_MAILVIEWS)

    if (viewName.startsWith("/")) {
      def tmp = viewName[1..-1]
      if (tmp.indexOf('/') > -1) {
        def i = tmp.lastIndexOf('/')
        buf << "/${tmp[0..i]}/${tmp[(i + 1)..-1]}"
      }
      else {
        buf << "/${viewName[1..-1]}"
      }
    }
    else {
      if (!request) throw new IllegalArgumentException(
          "Mail views cannot be loaded from relative view paths where there is no current HTTP request")
      def grailsAttributes = new DefaultGrailsApplicationAttributes(request.servletContext)
      buf << "${grailsAttributes.getControllerUri(request)}/${viewName}"

    }
    return buf.append(".gsp").toString()
  }

}
