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

import com.synergyj.grain.ui.MenuItem
import com.synergyj.grain.ui.Menu
import com.synergyj.grain.ui.MenuOption
import com.synergyj.grain.content.Content
import com.synergyj.grain.content.ContentType
import com.synergyj.grain.auth.User
import com.synergyj.grain.auth.Role
import com.synergyj.grain.auth.PersonAuthority
import com.synergyj.grain.course.Course
import com.synergyj.grain.course.CourseType
import com.synergyj.grain.course.Status
import grails.util.GrailsUtil
import com.synergyj.grain.course.ScheduledCourse
import com.synergyj.grain.course.ScheduledCourseStatus

class BootStrap {
  
  def springSecurityService
  
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
    
    if(!Role.count()){
      def adminRole = new Role(authority:'ROLE_ADMIN',description:'Administrador').save(flush:true)
      def userRole = new Role(authority:'ROLE_USER',description:'Usuario').save(flush:true)
      def guestUser = new Role()
      log.debug "Roles creados ${adminRole},${userRole}"
      String password = springSecurityService.encodePassword('password', 'user@user.com')
      def user = new User(email:'user@user.com',password:password).save(flush:true)
      password = springSecurityService.encodePassword('password', 'admin@admin.com')
      def admin = new User(email:'admin@admin.com',password:password).save(flush:true)
      log.debug "Usuarios creados: ${user.email},${admin.email}"
      PersonAuthority.create user, userRole, true
      PersonAuthority.create admin, adminRole, true
      log.debug "Autorización concedidad para los usuarios"
    }

    if(GrailsUtil.environment == "development" || GrailsUtil.environment=="test"){

      if(!Course.count()){
        def courseSpring = new Course(
            name:'Desarrollo profesional con Spring 3',
            content:'<p>Este es el contenido del curso</p>',
            contentType:ContentType.HTML,
            overview:"<p>Spring es una tecnología dedicada para permitir construir aplicaciones usando POJO’s….</p>",
            audience:"<p>Todos los desarrolladores Java</p>",
            prerequisites:"<p><ul><li>EJB</li><li>JDBC</li><li>Hibernate</li></ul></p>",
            goal:"<p>Entender los conceptos Inyección de dependencias e Inversión del Control </p>",
            method:"<p>Prácticos</p>",
            format:"<p>Formato del curso</p>",
            courseKey:"SPRING3.2011",
            courseType:CourseType.COURSE,
            status:Status.LIVE
        ).save(flush:true)

        def courseWebAdv = new Course(
            name:'Desarrollo Web Avanzado',
            content:'<p><ul><li>CSS y Javascript con jQuery</li><li>SpringMVC a profundidad</li><li>Flujos web con Spring WebFlow 2<br></li></ul></p>',
            contentType:ContentType.HTML,
            overview:"<p>En la actualidad, las aplicaciones web son la plataforma principal de muchos motores organizacionales, dandole la oportunidad a los usuarios de interactuar entre ellos con los datos de la operación.</p>",
            audience:"<p>Todos los desarrolladores Java</p>",
            prerequisites:"<p><ul><li>Servlets</li><li>JSP</li><li>MVC</li></ul></p>",
            goal:"<p>Desarrollar las habilidades necesarias para implementar un sitio web con funcionalidades atractivas</p>",
            method:"<p>Prácticos</p>",
            format:"<p>Formato del curso</p>",
            courseKey:"WEBADV.2011",
            courseType:CourseType.COURSE,
            status:Status.LIVE
        ).save(flush:true)
      }

      if(!ScheduledCourse.count()){
        def sc1 = new ScheduledCourse(
          beginDate:(new Date() + 45),
          limitRegistrationDate:(new Date() + 30),
          costByCourse:7000,
          costByModule:2000,
          scheduledCourseStatus:ScheduledCourseStatus.SCHEDULED,
          course:Course.get(1L)
        ).save(flush:true)

        def sc2 = new ScheduledCourse(
          beginDate:(new Date() + 45),
          limitRegistrationDate:(new Date() + 30),
          costByCourse:7000,
          costByModule:2000,
          scheduledCourseStatus:ScheduledCourseStatus.SCHEDULED,
          course:Course.get(2L)
        ).save(flush:true)
      }

    }
    
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
      def iconboxHtml = '''
<div class="iconbox">
    <img src="themes/wb/images/icon1.png" alt="" width="48" height="47" class="leftimage" /><h1>Business</h1><br />
    <span class="smalltitle">Duis autem vel eum iriure dolor</span> in hendrerit in vulputate velit esse  dolore eu feugiat nula facilisis at vero eros et accumsa. <span class="smalltitle"><a href="#">More</a></span><img src="themes/wb/images/arrow.png" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>

   <div class="iconbox">
    <img src="themes/wb/images/icon2.png" alt="" width="39" height="47" class="leftimage" />
    <h1>Security</h1><br />
    <span class="smalltitle">Duis autem vel eum iriure dolor</span> in hendrerit in vulputate velit esse  dolore eu feugiat nula facilisis at vero eros et accumsa. <span class="smalltitle"><a href="#">More</a></span><img src="themes/wb/images/arrow.png" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>

      <div class="iconbox">
    <img src="themes/wb/images/icon3.png" alt="" width="43" height="47" class="leftimage" />
    <h1>License</h1><br />
    <span class="smalltitle">Duis autem vel eum iriure dolor</span> in hendrerit in vulputate velit esse  dolore eu feugiat nula facilisis at vero eros et accumsa. <span class="smalltitle"><a href="#">More</a></span><img src="themes/wb/images/arrow.png" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>

      <div class="iconbox">
    <img src="themes/wb/images/icon4.png" alt="" width="46" height="47" class="leftimage" />
    <h1>Support</h1><br />
    <span class="smalltitle">Duis autem vel eum iriure dolor</span> in hendrerit in vulputate velit esse  dolore eu feugiat nula facilisis at vero eros et accumsa. <span class="smalltitle"><a href="#">More</a></span><img src="themes/wb/images/arrow.png" width="11" height="10" alt="" /></div>
'''
      def iconbox = new Content(title: 'iconbox', body: iconboxHtml, language: 'es', key: 'iconbox', type: ContentType.HTML)
      save(iconbox)

      def homeHtml = '''
<h2>Bienvenidos a Grain</h2>
  <h3>La plataforma de e-learning de SynergyJ</h3>

  <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nula facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdie. doming id quod. mazim placerat facer possim assum vel eum iriure dolor in hendrerit in vulputate velit esse molestie cons.<br/>
    <br/>
    Equat, vel illum dolore eu feugiat nulla facilisis at vero autem vel eum iriure dolor in hendrerit in vulputate. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nula facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent.</p>
  <p>Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nula facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdie. doming id quod. mazim placerat facer possim assum vel eum iriure dolor in hendrerit in vulputate velit esse molestie cons.</p>
'''
      def home = new Content(title: 'home', body: homeHtml, language: 'es', key: 'home', type: ContentType.HTML)
      save(home)

      def footerContentHtml = '''
<div id="corporateinfo">
      <div style="width:60px; float:left;">
        <img src="themes/wb/images/icon5.png" width="48" height="50" alt=""/>
      </div>
      <div style="width:220px; float:left;">
        <h5>Corporate Info</h5>
        Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nula facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril.
      </div>
    </div>
    <div id="recentnews">
      <div style="width:60px; float:left;">
        <img src="themes/wb/images/icon5_.png" width="49" height="50" alt=""/>
      </div>
      <div style="width:220px; float:left;">
        <h5>Recent News</h5>
        <ul>
          <li><a href="#">Autem vel eum iriure dolor in henderit</a></li>
          <li><a href="#">Vel illum dolore eu feugiat nula</a></li>
          <li><a href="#">Facilisis at vero eros et accumsan et</a></li>
          <li><a href="#">Lusto odio dignissim qui blandit</a></li>
        </ul>
      </div>
    </div>
    <div id="connect">
      <h5>Connect With Us</h5>
      <br/><a href="http://twitter.com/synergyj"><img src="themes/wb/images/icon6.png" alt="" width="39" height="49" class="leftimage"/></a><a href="http://facebook.com/synergyj"><img src="themes/wb/images/icon7.png" alt="" width="46" height="49" class="leftimage"/></a> <a href="http://linkedin.com/synergyj"><img src="themes/wb/images/icon8.png" alt="" width="52" height="49" class="leftimage"/></a><img src="themes/wb/images/icon9.png" alt="" width="34" height="49" class="leftimage"/></div>
'''
      def footerContent = new Content(title: 'footerContent', body: footerContentHtml, language: 'es', key: 'footerContent', type: ContentType.HTML)
      save(footerContent)

      def copyrightHtml = '''
© Copyright SynergyJ. All Rights Reserved
'''
      def copyright = new Content(title: 'copyright', body: copyrightHtml, language: 'es', key: 'copyright', type: ContentType.HTML)
      save(copyright)

      def latestnewsHtml = '''
        <h1>Latest News</h1><h4>What’s happening with us</h4>
  <p><img src="themes/wb/images/pic01.gif" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"><a href="#">More</a></span><img src="themes/wb/images/arrow.png" width="11" height="10" alt=""/></p>
  <p><img src="themes/wb/images/pic02.gif" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"><a href="#">More</a></span><img src="themes/wb/images/arrow.png" width="11" height="10" alt=""/></p>
  <p><img src="themes/wb/images/pic08.jpg" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Autem vel eum iriure dolor in</span> hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu.<span class="smalltitle"><a href="#">More</a></span><img src="themes/wb/images/arrow.png" width="11" height="10" alt=""/></p>
      '''
      def latestnews = new Content(title: 'latestnews', body: latestnewsHtml, language: 'es', key: 'latestnews', type: ContentType.HTML)
      save(latestnews)
    }
  }
  def destroy = {
  }
} 