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
package com.synergyj.grain.ui

class MenuOption {
  MenuItem item
  Integer order
  String permissions

  static belongsTo = [menu: Menu]

  static constraints = {
    item nullable: false
    order nullable: false
    permissions blank: true, nullable: true, minSize: 1, maxSize: 200
  }

  static mapping = {
    order column: 'menu_option_order'
  }
}
