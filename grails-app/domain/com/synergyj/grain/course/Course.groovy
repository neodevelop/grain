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
package com.synergyj.grain.course

class Course extends CourseContent implements Serializable{

  transient private static final long serialVersionUID = -1L

  String overview
  String audience
  String prerequisites
  String goal
  String method
  String format
  String courseKey
  String urlLandingPage
  CourseType courseType
  Status status
  SortedSet modules

  // Colores para eventos de calendario
  String color
  String backgroundColor
  String borderColor
  String textColor

  static hasMany = [modules:CourseModule]

  static constraints = {
    overview nullable:false,blank:false,size:1..1000
    audience nullable:false,blank:false,size:1..1000
    prerequisites nullable:false,blank:false,size:1..1000
    goal nullable:false,blank:false,size:1..1000
    method nullable:false,blank:false,size:1..1000
    format nullable:false,blank:false,size:1..1000
    courseKey nullable:false,blank:false,unique:true,size:1..20
    urlLandingPage url:true,size:1..100
    courseType nullable:false
    status nullable:false
    color blank:true,size:1..7
    backgroundColor blank:true,size:1..7
    borderColor blank:true,size:1..7
    textColor blank:true,size:1..7
  }

  static mapping = {
    cache true
    overview type:"text"
    audience type:"text"
    prerequisites type:"text"
    goal type:"text"
    method type:"text"
    format type:"text"
  }

  String toString() {
    courseKey
  }
}
