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
package com.synergyj.grain.data

import com.synergyj.grain.ui.Menu
import net.sf.ehcache.Ehcache
import net.sf.ehcache.CacheManager
import net.sf.ehcache.Element

class MenuService {
  static transactional = false
  static profiled = true
  static Ehcache menuCache = CacheManager.getInstance().getCache("menus")

  def findMenu(key) {
    def result
    def lookup = key
    result = menuCache.get(lookup)?.value
    if (!result) {
      result = Menu.findByName(key)
      if(result) {
        menuCache.put(new Element(lookup, result))
      }
    }
    result
  }
}
