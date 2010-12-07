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
package com.synergyj.grain.content

import org.springframework.web.servlet.support.RequestContextUtils
import org.springframework.context.i18n.LocaleContextHolder

class ContentTagLib {
  def contentService
  static namespace = 'content'

  def body = {attrs ->
    def key = attrs.key
    assert key, 'The key is required'
    def contentStr
    def language = attrs.language ?: RequestContextUtils.getLocale(request).getLanguage()
    def content = contentService.findContent(key, language)
    if(content) {
      contentStr = content.body
    } else {
      contentStr = "Content not found for key '${key}' and language '${language}'"
    }

    out << contentStr
  }
}
