/*
 * Copyright 2002-2010 the original author or authors.
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
package com.synergyj.grain.test

import geb.spock.GebReportingSpec
import org.codehaus.groovy.grails.commons.ConfigurationHolder

abstract class BaseTests extends GebReportingSpec {
  def static base_url = ConfigurationHolder.config.grails.serverURL

  String getBaseUrl() {
    base_url
  }

  File getReportDir() {
    new File("target/test-reports/geb")
  }

}
