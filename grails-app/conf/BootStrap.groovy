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
import grails.converters.JSON
import com.synergyj.grain.course.CourseSession

class BootStrap {
  
  def springSecurityService
  def courseSessionService
  
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

    JSON.registerObjectMarshaller(Date) {
      return it?.format("yyyy-MM-dd'T'HH:mm:ss'Z'")
    }

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
            status:Status.LIVE,
            color:"",
            backgroundColor:"#204d20",
            borderColor:"#4d794d",
            textColor:"#cccc80"
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
            status:Status.LIVE,
            color:"",
            backgroundColor:"#990066",
            borderColor:"#bf609f",
            textColor:"#fbdbee"
        ).save(flush:true)

        def courseHibernate = new Course(
            name:'Persistencia en Java con Hibernate',
            content:'<p><ul><li>Objetos persistentes</li><li>Transacciones</li><li>SessionFactory</li></ul></p>',
            contentType:ContentType.HTML,
            overview:"<p>La persistencia es importante, o no?</p>",
            audience:"<p>Todos los desarrolladores Java</p>",
            prerequisites:"<p><ul><li>BD</li><li>JSP</li><li>SQL</li></ul></p>",
            goal:"<p>Manejar Hibernate como se debe</p>",
            method:"<p>Prácticos</p>",
            format:"<p>Formato del curso</p>",
            courseKey:"HIBERNATE.2011",
            courseType:CourseType.COURSE,
            status:Status.LIVE,
            color:"",
            backgroundColor:"#794d20",
            borderColor:"#c6b39f",
            textColor:"#ffecdf"
        ).save(flush:true)

      }

      if(!ScheduledCourse.count()){
        def sc1 = new ScheduledCourse(
          beginDate:(new Date() + 15),
          limitRegistrationDate:(new Date() + 10),
          costByCourse:7000,
          costByModule:2000,
          scheduledCourseStatus:ScheduledCourseStatus.SCHEDULED,
          course:Course.get(1L)
        ).save(flush:true)

        def sc2 = new ScheduledCourse(
          beginDate:(new Date() + 15),
          limitRegistrationDate:(new Date() + 10),
          costByCourse:7000,
          costByModule:2000,
          scheduledCourseStatus:ScheduledCourseStatus.SCHEDULED,
          course:Course.get(2L)
        ).save(flush:true)

        def sc3 = new ScheduledCourse(
          beginDate:(new Date() + 15),
          limitRegistrationDate:(new Date() + 10),
          costByCourse:7000,
          costByModule:2000,
          scheduledCourseStatus:ScheduledCourseStatus.SCHEDULED,
          course:Course.get(3L)
        ).save(flush:true)

        //Creamos sesiones para todos los cursos
        ScheduledCourse.list().each{ scheduledCourse ->
          def begin = scheduledCourse.beginDate
          5.times{
            begin += 7
            courseSessionService.createSession4ScheduledCourse(scheduledCourse.id,begin)
          }
        }

      }

    }
    
    if (MenuItem.count() == 0) {
      def home = new MenuItem(labelCode: 'menu.item.home').link(mapping: 'home')
      save(home)

      def about = new MenuItem(labelCode: 'menu.item.about').controller('info').action('show').id('about')
      save(about)

      def calendar = new MenuItem(labelCode: 'menu.item.calendar').controller('calendar').action('index')
      save(calendar)

      def services = new MenuItem(labelCode: 'menu.item.services').link(controller: 'info', action: 'show', id: 'services')
      save(services)

      def account = new MenuItem(labelCode: 'menu.item.account').link(mapping: 'me')
      save(account)

      def register = new MenuItem(labelCode: 'menu.item.register').link(mapping: 'signup')
      save(register)

      def login = new MenuItem(labelCode: 'menu.item.login').link(mapping: 'login')
      save(login)

      def logout = new MenuItem(labelCode: 'menu.item.logout').link(mapping: 'logout')
      save(logout)

      def contact = new MenuItem(labelCode: 'menu.item.contact').controller('info').action('show').id('contact')
      save(contact)

      def google = new MenuItem(labelCode: 'menu.item.google').url('http://google.com')
      save(google)

      def homeOption = new MenuOption(item: home, order: 0)
      save(homeOption)
      def calendarOption = new MenuOption(item: calendar, order: 1)
      save(calendarOption)
      def aboutOption = new MenuOption(item: about, order: 2)
      save(aboutOption)
      def servicesOption = new MenuOption(item: services, order: 3)
      save(servicesOption)
      def contactOption = new MenuOption(item: contact, order: 4)
      save(contactOption)
      def accountOption = new MenuOption(item: account, order: 5, permissions: 'isAuthenticated()')
      save(accountOption)
      def registerOption = new MenuOption(item: register, order: 6, permissions: 'isAnonymous()')
      save(registerOption)
      def loginOption = new MenuOption(item: login, order: 7, permissions: 'isAnonymous()')
      save(loginOption)
      def logoutOption = new MenuOption(item: logout, order: 8, permissions: 'isAuthenticated()')
      save(logoutOption)

      def topMenu = new Menu(name: 'top')
      save(topMenu)
      topMenu.option(homeOption).option(calendarOption).option(logoutOption)
      topMenu.option(accountOption).option(loginOption).option(registerOption)
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
    <img src="themes/wb/images/icon1.png" alt="" width="48" height="47" class="leftimage" /><h1>Cursos</h1><br />
    <span class="smalltitle">En cursos de desarrollo de software</span> estamos convencidos que nuestra experiencia y la práctica del conocimiento será lo que te dará la mayor satisfacción. <img src="themes/wb/images/arrow.png" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>

   <div class="iconbox">
    <img src="themes/wb/images/icon2.png" alt="" width="39" height="47" class="leftimage" />
    <h1>Comunidad</h1><br />
    <span class="smalltitle">No serás sólo un alumno,</span> cuando asistes a nuestros cursos, te conviertes en parte de la comunidad de desarrolladores que realmente hacen diferencia en su profesión. <img src="themes/wb/images/arrow.png" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>

      <div class="iconbox">
    <img src="themes/wb/images/icon3.png" alt="" width="43" height="47" class="leftimage" />
    <h1>Acercate</h1><br />
    <span class="smalltitle">Nuestros instructores</span> son referencias internacionales de desarrollo de software, conócelos.<span class="smalltitle">
    <br><a href="http://springhispano.org">SpringHispano.org</a>
    <br><a href="http://grails.org.mx">GrailsMX</a>
    <br><a href="http://artesanos.de/software">Artesanos de Software</a>
    <br><a href="http://vivecodigo.org">ViveCodigo.org</a>
    </span><img src="themes/wb/images/arrow.png" width="11" height="10" alt="" /></div>
    <div class="iconline"></div>

      <div class="iconbox">
    <img src="themes/wb/images/icon4.png" alt="" width="46" height="47" class="leftimage" />
    <h1>Inscíbete</h1><br />
    <span class="smalltitle">Es gratis!</span> Mantente actualizado, recibe promociones y alístate para ser parte de la comunidad de desarrolladores en constante evolucion. <img src="themes/wb/images/arrow.png" width="11" height="10" alt="" /></div>
'''
      def iconbox = new Content(title: 'iconbox', body: iconboxHtml, language: 'es', key: 'iconbox', type: ContentType.HTML)
      save(iconbox)

      def homeHtml = '''
    <h2>Bienvenidos a este sitio</h2>
  <h3>Desde aquí podrás ser parte del entrenamiento impartido por SynergyJ</h3>

  <p>Es momento de potenciar tu desempeño y atender tu plan de carrera de desarrollador de la mejor manera, para ello, hemos puesto a tu disposición esta aplicación, donde podras administrar los cursos que deseas tomar y planear la adquisicion de los skills necesarios en esta rama tan competida.
   Desde aquí podrás:.<br/>
    <ul>
      <li>Inscribirte a un curso</li>
      <li>Pagar tu curso</li>
      <li>Subir tus comprobantes de pago</li>
      <li>Recoger tu diploma</li>
      <li>Obtener toda la información para inscribirte</li>
      <li>Ver nuestro calendario de cursos y eventos</li>
    </ul>
    </p>
  <p>Próximamente podrás:</p>
    <ul>
      <li>Recomendar este curso para recibir descuentos</li>
      <li>Tener tu historial académico con nosotros</li>
      <li>Enviar comentarios</li>
      <li>Enviar tu diploma</li>
      <li>Y algunas otras cosas más...</li>
    </ul>
'''
      def home = new Content(title: 'home', body: homeHtml, language: 'es', key: 'home', type: ContentType.HTML)
      save(home)

      def footerContentHtml = '''
<div id="corporateinfo">
      <div style="width:60px; float:left;">
        <img src="themes/wb/images/icon5.png" width="48" height="50" alt=""/>
      </div>
      <div style="width:220px; float:left;">
        <h5>Acerca de nosotros</h5>
        SynergyJ es una empresa formada por un grupo de expertos en tecnologías y metodologías ágiles para el desarrollo de software que provee soluciones de negocio, usando herramientas efectivas y basados en la experiencia de la implementación de software productivo.
      </div>
    </div>
    <div id="recentnews">
      <div style="width:60px; float:left;">
        <img src="themes/wb/images/icon5_.png" width="49" height="50" alt=""/>
      </div>
      <div style="width:220px; float:left;">
        <h5>Nuestra misión</h5>
        Implementar las mejores soluciones de desarrollo de software de acuerdo a las necesidades empresariales, basándonos en el éxito obtenido en las implementeaciones previas, aprovechando al máximo los recursos humanos, financieros y tecnológicos.
      </div>
    </div>
    <div id="connect">
      <h5>Conéctate con nosotros</h5>
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
        <h1>Testimonios</h1><h4>Que dicen de nosotros?</h4>
  <p><img src="themes/wb/images/pic01.gif" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Miguel Angel Huerta ( PortoMX )</span> "...Hicieron una muy buena seleccion de los temas al dar más que un curso extenso una vision sobre lo que se puede hacer con spring..."<img src="themes/wb/images/arrow.png" width="11" height="10" alt=""/></p>
  <p><img src="themes/wb/images/pic02.gif" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Gerardo Javier Montes Solache ( Sictel ECM )</span> "...El curso estubo bien, de facil conprención, y los expositores considero que tienen el nivel necesario para poder dar las bases de spring..." <img src="themes/wb/images/arrow.png" width="11" height="10" alt=""/></p>
  <p><img src="themes/wb/images/pic08.jpg" alt="" width="67" height="67" vspace="5" class="leftimage"/><span class="smalltitle">Roberto Salvador Olguín Lozano ( Bursatec )</span> "...El taller fue muy bueno, hablaron de todo sin caer en exceso en algún tema, me parecio de mucha ayuda y quiero seguir conociendo de sus reuniones, GRACIAS..." <img src="themes/wb/images/arrow.png" width="11" height="10" alt=""/></p>
      '''
      def latestnews = new Content(title: 'latestnews', body: latestnewsHtml, language: 'es', key: 'latestnews', type: ContentType.HTML)
      save(latestnews)
    }
  }
  def destroy = {
  }
} 