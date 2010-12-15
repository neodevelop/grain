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
package com.synergyj.grain.auth

import com.synergyj.grain.test.BaseTests
import com.synergyj.grain.test.pages.SignupPage

class UserRegisterSpec extends BaseTests {

  def 'at the register page'() {
    when:
    to SignupPage

    then:
    at SignupPage
  }

  def 'submit the form without data'() {
    when:
    to SignupPage
    sendButton.click()

    then:
    at SignupPage
    errors.text() != ''
  }

  def 'submit the form only with email'() {
    when:
    to SignupPage
    email = 'user@server.com'
    sendButton.click()

    then:
    at SignupPage
    errors.text() != ''
  }

  def 'submit the form only with password'() {
    when:
    to SignupPage
    password = 'supersecret'
    sendButton.click()

    then:
    at SignupPage
    errors.text() != ''
  }

  def 'submit the form with wrong email and right password'() {
    when:
    to SignupPage
    email = 'usercom.com'
    password = 'supersecret'
    sendButton.click()

    then:
    at SignupPage
    errors.text() != ''
  }

  def 'submit the form with wrong password and right email'() {
    when:
    to SignupPage
    email = 'user@server.com'
    password = 'su'
    sendButton.click()

    then:
    at SignupPage
    errors.text() != ''
  }

  def 'submit the form with right password and right email'() {
    when:
    to SignupPage
    email = 'user@server.com'
    password = 'supersecret'
    sendButton.click()

    then:
    at SignupPage
    errors.text() == null
  }
}
