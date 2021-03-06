/*
 * Copyright 2002-2011 the original author or authors.
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

import com.synergyj.grain.auth.User

abstract class AbstractBaseContent implements Serializable {
  String title
  String body
  String language
  String key
  User author
  ContentType type
  Date dateCreated
  Date lastUpdated

  static mapping = {
    cache true
    body type: "text"
    tablePerHierarchy false
    key column: 'ab_content_key'
    type column: 'ab_content_type'
  }

  static constraints = {
    title blank: false, nullable: false, minSize: 1, maxSize: 200
    body blank: false, nullable: false
    language nullable: false, maxSize: 100
    key nullable: true, blank: true, minSize: 1, maxSize: 200
    author nullable: true
    type nullable: false
    lastUpdated display: false
    dateCreated display: false
  }
}
