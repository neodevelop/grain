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

class EventInfo {
  Long id
  String title
  Boolean allDay = false
  Date start
  Date end
  String url
  String className
  Boolean editable = false

  String color
  String backgroundColor
  String borderColor
  String textColor

  // Considerar elementos para eventRender
  // Ver el plugin de jQuery de qTip http://craigsworks.com/projects/qtip2/

}