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

class MenuTagLib {
  def menuService

  static namespace = 'menu'
  static returnObjectForTags = ['options']

  def options = {attrs ->
    def name = attrs.name
    assert name
    def result = []
    def menu = menuService.findMenu(name)

    if (menu) {
      def byOrder = [compare: { a, b -> a.order.compareTo(b.order) }] as Comparator
      result = menu.items.sort(byOrder)
    }
    result
  }

  def valueForKey(params, key) {
    def result = null
    def param = params.find {param ->
      param.name == key
    }
    if (param) {
      result = param.value
    }
    result
  }

  def extractParams(params) {
    def result = [:]
    def foundParams = params.findAll {param ->
      param.name.startsWith('p')
    }
    foundParams.each {param ->
      result.put(param.name, param.value)
    }
    result
  }

  def link = {attrs ->
    def option = attrs.option
    assert option
    def item = option.item
    def type = item.type
    def params = item.linkParams
    def link = ''

    switch (type.ordinal()) {
      case 0:
        //Mapping
        break
      case 1:
        //Controller
        def controller = valueForKey(params, 'controller')
        assert controller

        def action = valueForKey(params, 'action')
        def id = valueForKey(params, 'id')
        def extraParams = extractParams(params)

        def linkParams = [:]
        linkParams.controller = controller

        if (action) {
          linkParams.action = action
        }

        if (id) {
          linkParams.id = id
        }

        if (extraParams) {
          linkParams.params = extraParams
        }

        link = g.createLink(linkParams)
        break
      case 2:
        //Url
        def url = valueForKey(params, 'url')
        assert url
        link = url
        break
      default:
        log.warn "no preparados aun para ${type.dump()}"
        log.warn item.dump()
        break
    }
    out << link
  }
}
