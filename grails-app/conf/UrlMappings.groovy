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
    name me: '/me' {
      controller = 'user'
      action = 'me'
    }
    name updateme: '/updateme' {
      controller = 'user'
      action = 'edit'
    }
    name home: '/' {
      controller = 'home'
      action = 'index'
    }
    name forgotPassword: '/forgotPassword' {
      controller = 'user'
      action = 'forgotPassword'
    }
    name signup: '/signup' {
      controller = 'user'
      action = 'signup'
    }
    name content: "/$id" {
      controller = 'page'
      action = 'show'
    }
    name addMeFromLanding: "/addMeFromLanding"(controller:"landing"){
      action = [GET:"addMe"]
    }
    "500"(controller: 'error')
  }
}
