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

import grails.test.ControllerUnitTestCase

class IPNControllerTests extends ControllerUnitTestCase {
  protected void setUp() {
    super.setUp()
  }

  protected void tearDown() {
    super.tearDown()
  }

  void testIndex(){
    mockParams.NOTIFICACION = """
    <NOTIFICACION>
      <TIPONOTIFICACION>1</TIPONOTIFICACION>
      <OPERACIONES>
        <OPERACION>
          <TIPO>1</TIPO>
          <ID>7250537a3ba2433db27d</ID>
        </OPERACION>
        <OPERACION>
          <TIPO>1</TIPO>
          <ID>ab6ad8c4529e42eab0ae</ID>
         </OPERACION>
        </OPERACIONES>
    </NOTIFICACION>
    """
    controller.index()
  }
}
