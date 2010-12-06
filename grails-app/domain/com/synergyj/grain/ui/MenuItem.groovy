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

import static com.synergyj.grain.ui.LinkParam.*

class MenuItem {
  String labelCode
  LinkType type
  String permissions

  static hasMany = [linkParams: LinkParam]

  static constraints = {
    labelCode blank: false, nullable: false, minSize: 1, maxSize: 100
    type nullable: false
    permissions blank: true, nullable: true, minSize: 1, maxSize: 200
  }

  public String toString() {
    labelCode
  }

  def isController() {
    def hasLinkParamController
    if (this.linkParams) {
      hasLinkParamController = this.linkParams.find {param ->
        param.name == CONTROLLER
      }
    } else {
      hasLinkParamController = true
    }
    type == LinkType.CONTROLLER && hasLinkParamController
  }

  def link(params) {
    if (params.controller) {
      type = LinkType.CONTROLLER
      addToLinkParams(controller(params.controller))
      if (params.action) {
        this.addToLinkParams(action(params.action))
      }
      if (params.id) {
        this.addToLinkParams(id(params.id))
      }
    }
  }

  def url(url) {
    type = LinkType.URL
    this.addToLinkParams(LinkParam.url(url))
    this
  }

  def controller(controller) {
    type = LinkType.CONTROLLER
    assert isController()
    this.addToLinkParams(LinkParam.controller(controller))
    this
  }

  def action(action) {
    assert isController()
    assert this.linkParams.find {param ->
      param.name == CONTROLLER
    }
    this.addToLinkParams(LinkParam.action(action))
    this
  }

  def id(id) {
    assert isController()
    this.addToLinkParams(LinkParam.id(id))
    this
  }
}
