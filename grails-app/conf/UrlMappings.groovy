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

class UrlMappings {
  static mappings = {
    "/$controller/$action?/$id?"{
			constraints {
			}
		}
    name login:'/login' {
      controller = 'login'
      action = 'index'
    }
    name logout:'/logout' {
      controller = 'logout'
      action = 'index'
    }
    name me: '/me' {
      controller = 'user'
      action = 'me'
    }
    name updateme: '/updateme' {
      controller = 'user'
      action = 'changeMyInfo'
    }
    name changePassword: '/changePassword' {
      controller = 'user'
      action = 'changePassword'
    }
    name home: '/' {
      controller = 'home'
      action = 'index'
    }
    name forgotPassword: '/forgotPassword' {
      controller = 'user'
      action = 'forgotPassword'
    }
    name resetPassword: '/resetPassword' {
      controller = 'user'
      action = 'resetPassword'
    }
    name signup: '/signup' {
      controller = 'user'
      action = 'signup'
    }
    name calendar:"/calendar"{
      controller = 'calendar'
      action = 'index'
    }
    name payment:"/payment"{
      controller = 'payment'
      action = 'index'
    }
    name receivePayment:"/receivePayment"{
      controller = "payment"
      action = "receive"
    }
    name confirmRegistration:"/confirmRegistration"{
      controller = "registration"
      action = "confirm"
    }
    name content: "/$id" {
      controller = 'page'
      action = 'show'
    }
    name addMeFromLanding: "/addMeFromLanding"(controller:"landing"){
      action = [POST:"addMe"]
    }
    name addMeFromLandingNoPost: "/addMeFromLandingNoPost"(controller:"landing"){
      action = [GET:"addMeNoPost"]
    }
    name ipn:"/ipn"(controller:"IPN"){

    }
    "403"(controller: 'error',action: 'forbidden')
    "404"(controller: 'error',action: 'notfound')
    "500"(controller: 'error',action: 'internalError')
  }
}
