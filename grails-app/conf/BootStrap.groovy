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

import com.synergyj.grain.ui.MenuItem
import com.synergyj.grain.ui.LinkType
import com.synergyj.grain.ui.Menu
import com.synergyj.grain.ui.MenuOption

class BootStrap {
  def save(domain) {
    if (domain.hasErrors()) {
      domain.errors.each {error ->
        println error.dump()
      }
    } else {
      domain.save(flush: true)
    }

  }

  def init = { servletContext ->
    if (MenuItem.count() == 0) {
      def home = new MenuItem(labelCode: 'menu.item.home').controller('home').action('index')
      save(home)

      def about = new MenuItem(labelCode: 'menu.item.about').controller('info').action('show').id('1')
      save(about)

      def services = new MenuItem(labelCode: 'menu.item.services').link(controller: 'info', action: 'show', id: '2')
      save(services)

      def contact = new MenuItem(labelCode: 'menu.item.contact').controller('info').action('show').id('3')
      save(contact)

      def google = new MenuItem(labelCode: 'menu.item.google').url('http://google.com')
      save(google)

      def homeOption = new MenuOption(item: home, order: 0)
      save(homeOption)

      def aboutOption = new MenuOption(item: about, order: 1)
      save(aboutOption)
      def servicesOption = new MenuOption(item: services, order: 2)
      save(servicesOption)
      def contactOption = new MenuOption(item: contact, order: 3)
      save(contactOption)

      def menu = new Menu(name: 'top')
      save(menu)
      menu.option(homeOption).option(aboutOption).option(servicesOption).option(contactOption)
      save(menu)

    }
  }
  def destroy = {
  }
} 