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
package com.synergyj.grain

class ErrorController {
  def forbidden = {
    def errorCode = request.'javax.servlet.error.status_code'
    def uri = request.'javax.servlet.error.request_uri'
    flash.error = "${message(code:'error.forbidden',args:[errorCode,uri])}"
    redirect(uri:'/')
  }

  def notfound = {
    def errorCode = request.'javax.servlet.error.status_code'
    def uri = request.'javax.servlet.error.request_uri'
    flash.error = "${message(code:'error.notfound',args:[errorCode,uri])}"
    redirect(uri:'/')
  }

  def internalError = {
    def errorCode = request?.'javax.servlet.error.status_code'
    def exception = request?.exception
    flash.error = "${message(code:'error.internalError',args:[errorCode,exception?.message])}"
    redirect(uri:'/')
  }

}
