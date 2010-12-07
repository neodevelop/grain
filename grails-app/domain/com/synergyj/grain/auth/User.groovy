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
package com.synergyj.grain.auth

class User {

  Date dateCreated
  Date lastUpdated

  String email
  String firstName
  String lastName
  Boolean enabled
  String description
  String company
  String geolocation
  String website
  Boolean emailShow


  String password
  Boolean accountExpired
  Boolean accountLocked
  Boolean passwordExpired


  static constraints = {
    email nullable: false, blank: false, size: 1..200, unique: true, email: true
    password nullable: false, blank: false, size: 5..25
    firstName nullable: true, blank: true, size: 0..200
    lastName nullable: true, blank: true, size: 0..200
    company nullable: true, blank: true, size: 0..100
    geolocation nullable: true, blank: true, size: 0..200
    description nullable: true, blank: true
    website nullable: false, blank: false, size: 1..100, url: true
    geolocation nullable: true, blank: true, size: 0..200
    lastUpdated display: false
    dateCreated display: false

  }

  static mapping = {
    cache true
    table 'gr_people'

    password column: '`password`'
    description type: "text"
  }

  Set<Role> getAuthorities() {
    UserRole.findAllByUser(this).collect { it.role } as Set
  }

  String toString() {
    "${firstName} ${lastName}"
  }
}
