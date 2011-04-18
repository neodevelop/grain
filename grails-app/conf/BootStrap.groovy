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
import com.synergyj.grain.content.Content
import com.synergyj.grain.content.ContentType

class BootStrap {
  def save(domain) {
    assert domain
    if (domain.hasErrors()) {
      println "errors"
      domain.errors.each {error ->
        println error.dump()
      }
    } else {
      println "trying to save"
      def saved = domain.save(flush: true, failOnError: true)
      if (!saved) {
        domain.errors.each {error ->
          println error.dump()
        }
      }
    }

  }

  def init = { servletContext ->
    if (MenuItem.count() == 0) {
      def home = new MenuItem(labelCode: 'menu.item.home').link(mapping: 'home')
      save(home)

      def about = new MenuItem(labelCode: 'menu.item.about').controller('info').action('show').id('about')
      save(about)

      def services = new MenuItem(labelCode: 'menu.item.services').link(controller: 'info', action: 'show', id: 'services')
      save(services)

      def account = new MenuItem(labelCode: 'menu.item.account').link(mapping: 'me')
      save(account)

      def register = new MenuItem(labelCode: 'menu.item.register').link(mapping: 'signup')
      save(register)

      def login = new MenuItem(labelCode: 'menu.item.login').link(mapping: 'login')
      save(login)

      def contact = new MenuItem(labelCode: 'menu.item.contact').controller('info').action('show').id('contact')
      save(contact)

      def google = new MenuItem(labelCode: 'menu.item.google').url('http://google.com')
      save(google)

      def homeOption = new MenuOption(item: home, order: 0)
      save(homeOption)
      def aboutOption = new MenuOption(item: about, order: 1)
      save(aboutOption)
      def servicesOption = new MenuOption(item: services, order: 2)
      save(servicesOption)
      def accountOption = new MenuOption(item: account, order: 4, permissions: 'isAuthenticated()')
      save(accountOption)
      def loginOption = new MenuOption(item: login, order: 5, permissions: 'isAnonymous()')
      save(loginOption)
      def registerOption = new MenuOption(item: register, order: 4, permissions: 'isAnonymous()')
      save(registerOption)
      def contactOption = new MenuOption(item: contact, order: 3)
      save(contactOption)

      def topMenu = new Menu(name: 'top')
      save(topMenu)
      topMenu.option(homeOption).option(aboutOption)
      topMenu.option(contactOption).option(accountOption).option(loginOption).option(registerOption)
      save(topMenu)


      def homeOptionB = new MenuOption(item: home, order: 0)
      save(homeOptionB)
      def aboutOptionB = new MenuOption(item: about, order: 1)
      save(aboutOptionB)
      def servicesOptionB = new MenuOption(item: services, order: 2)
      save(servicesOptionB)
      def accountOptionB = new MenuOption(item: account, order: 4)
      save(accountOptionB)
      def contactOptionB = new MenuOption(item: contact, order: 3)
      save(contactOptionB)

      def bottomMenu = new Menu(name: 'bottom')
      save(bottomMenu)
      bottomMenu.option(homeOptionB).option(aboutOptionB).option(servicesOptionB).option(contactOptionB).option(accountOptionB)
      save(bottomMenu)

    }

    def c = Content.count()
    println c
    if (c == 0) {
      def iconbox = new Content(title: 'iconbox', body: 'iconbox', language: 'es', key: 'iconbox', type: ContentType.HTML)
      save(iconbox)

      def home = new Content(title: 'home', body: 'home', language: 'es', key: 'home', type: ContentType.HTML)
      save(home)

      def footerContent = new Content(title: 'footerContent', body: 'footerContent', language: 'es', key: 'footerContent', type: ContentType.HTML)
      save(footerContent)

      def copyright = new Content(title: 'copyright', body: 'copyright', language: 'es', key: 'copyright', type: ContentType.HTML)
      save(copyright)

      def latestnewsHtml = '''
        <h1>Latest News</h1><h4>What’s happening with us</h4>
  <p><img src="themes/wb/images/pic01.gif" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"><a href="#">More</a></span><img src="${createLinkTo(dir: 'themes/wb/images', file: 'arrow.png')}" width="11" height="10" alt=""/></p>
  <p><img src="themes/wb/images/pic02.gif" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"><a href="#">More</a></span><img src="${createLinkTo(dir: 'themes/wb/images', file: 'arrow.png')}" width="11" height="10" alt=""/></p>
  <p><img src="themes/wb/images/pic08.jpg" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"><a href="#">More</a></span><img src="${createLinkTo(dir: 'themes/wb/images', file: 'arrow.png')}" width="11" height="10" alt=""/></p>
      '''
      def latestnews = new Content(title: 'latestnews', body: latestnewsHtml, language: 'es', key: 'latestnews', type: ContentType.HTML)
      save(latestnews)
    }
  }
  def destroy = {
  }
} 