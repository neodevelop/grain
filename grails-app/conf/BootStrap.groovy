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
import com.synergyj.grain.course.ReceiptAWS
import com.synergyj.grain.course.Receipt
import grails.util.GrailsUtil
import com.synergyj.grain.course.ScheduledCourse
import com.synergyj.grain.course.ScheduledCourseStatus
import grails.converters.JSON
import com.synergyj.grain.course.Promotion
import com.synergyj.grain.course.KindPromotion
import com.synergyj.grain.course.PromotionPerScheduledCourse
import com.synergyj.grain.course.Registration
import com.synergyj.grain.course.RegistrationStatus
import com.synergyj.geedback.Questionnaire
import com.synergyj.geedback.Question
import com.synergyj.geedback.KindOfQuestion
import com.synergyj.geedback.OptionQuestion


class BootStrap {

  def springSecurityService
  def courseSessionService
  def s3AssetService

  def save(domain) {
    assert domain
    if (domain.hasErrors()) {
      log.error "errors"
      domain.errors.each {error ->
        log.error error.dump()
      }
    } else {
      log.debug "trying to save"
      def saved = domain.save(flush: true, failOnError: true)
      if (!saved) {
        domain.errors.each {error ->
          log.error error.dump()
        }
      }
    }
  }

  def init = { servletContext ->

    JSON.registerObjectMarshaller(Date) {
      return it?.format("yyyy-MM-dd'T'HH:mm:ss'Z'")
    }

    if (GrailsUtil.environment == "development" || GrailsUtil.environment == "test") {
      createReceipts()
      createUsers()
      createCourses()
      createScheduledCourses()
      createPromotions()
      createRegistrations()
      createMenuItems()
      createContents()
      createQuestionnarie()
      createQuestionsAndOptions()
    }

  }

  def createQuestionnarie() {
    if (!Questionnaire.count()) {
      log.debug("Creando un cuestionario de prueba")
      def questionnaire = new Questionnaire(name: "Evaluación de curso", description: "Cuestionario para evaluación de desempeño y aprovechamiento de curso")
      questionnaire.save()
      log.debug("Cuestionario creado")
    }
  }

  def createQuestionsAndOptions() {
    if (!Question.count()) {
      log.debug("Creando las preguntas para el cuestionario")
      def q1 = new Question(
          question: "Los temas expuestos, ¿ fueron de manera clara y de fácil comprensión?",
          orderTo: 1, kindOfQuestion: KindOfQuestion.TRUE_FALSE
      )
      def q2 = new Question(
          question: "El contenido de los temas expuestos consideras que fue:",
          orderTo: 2, kindOfQuestion: KindOfQuestion.CHOOSE_OPTION
      )
      def q3 = new Question(
          question: "Los temas tratados, fueron:",
          orderTo: 3, kindOfQuestion: KindOfQuestion.CHOOSE_OPTION
      )
      def q4 = new Question(
          question: "Con este curso, consideras que se ampliaron tus conocimientos y comprensión acerca de tu trabajo.",
          orderTo: 4, kindOfQuestion: KindOfQuestion.TRUE_FALSE
      )
      def q5 = new Question(
          question: "La presentación, ¿incluyó suficientes ejemplos prácticos, que facilitaron la comprensión del curso?",
          orderTo: 5, kindOfQuestion: KindOfQuestion.TRUE_FALSE
      )
      def q6 = new Question(
          question: "¿Cómo consideras la calidad de las presentaciones?",
          orderTo: 6, kindOfQuestion: KindOfQuestion.CHOOSE_OPTION
      )
      def q7 = new Question(
          question: "¿El curso cubrió tus expectativas?",
          orderTo: 7, kindOfQuestion: KindOfQuestion.TRUE_FALSE
      )
      def q8 = new Question(
          question: "Los conceptos de cómo aplicar los conocimientos adquiridos en tu trabajo, ¿te han quedado claros...?",
          orderTo: 8, kindOfQuestion: KindOfQuestion.CHOOSE_OPTION
      )
      def q9 = new Question(
          question: "Por favor escribe los temas tratados que consideres de mayor importancia:",
          orderTo: 9, kindOfQuestion: KindOfQuestion.SHORT_ANSWER
      )
      def q10 = new Question(
          question: "¿Qué temas consideras tratar mas brevemente o eliminarse?",
          orderTo: 10, kindOfQuestion: KindOfQuestion.SHORT_ANSWER
      )
      def q11 = new Question(
          question: "¿Qué temas deberían de agregarse?",
          orderTo: 11, kindOfQuestion: KindOfQuestion.SHORT_ANSWER
      )
      def q12 = new Question(
          question: "La limpieza, iluminación y ventilación del lugar, consideras que fue:",
          orderTo: 12, kindOfQuestion: KindOfQuestion.CHOOSE_OPTION
      )
      def q13 = new Question(
          question: "Las sillas, mesas y las condiciones del aula, consideras que son:",
          orderTo: 13, kindOfQuestion: KindOfQuestion.CHOOSE_OPTION
      )
      def q14 = new Question(
          question: "El equipo didáctico y audiovisual, consideras que fue:",
          orderTo: 14, kindOfQuestion: KindOfQuestion.CHOOSE_OPTION
      )
      def q15 = new Question(
          question: "Por favor si consideras que olvidamos algo o nos quieres dejar una opinión comentario o dudas, háznolos saber:",
          orderTo: 15, kindOfQuestion: KindOfQuestion.DESCRIPTION
      )
      def questions = [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15]
      log.debug("Obteniendo el cuestionario")
      def quiz = Questionnaire.get(1L)
      log.debug("Asignando preguntas al cuestionario")
      questions.each { q ->
        quiz.addToQuestions(q)
      }
      quiz.save()
      log.debug("Preguntas y cuestionario guardados")
      log.debug("Agregando respuestas al cuestionario")

      //q1.addToOptions(new OptionQuestion(optionDescription: "", orderTo: 1))

    }
  }

  def createContents() {
    if (!Content.count()) {
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

  def createMenuItems() {
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
  }

  def createRegistrations() {
    if (!Registration.count()) {
      ScheduledCourse.list().each { sc ->
        User.list().each { user ->
          def registration = new Registration(student: user, registrationStatus: RegistrationStatus.REGISTERED)
          sc.addToRegistrations(registration)
          sc.save()
        }
      }
    }
  }

  def createPromotions() {
    // Creamos las promociones
    if (!Promotion.count()) {
      def p1 = new Promotion(
          promotionKey: "USB",
          description: "Llevate una memoria USB si apartas tu lugar con el 50%",
          discount: new BigDecimal("0"),
          kindPromotion: KindPromotion.GIFT).save(flush: true)
      def p2 = new Promotion(
          promotionKey: "USB",
          description: "LLeva tu laptop y te hacemos el 5% de descuento",
          discount: new BigDecimal("5"),
          kindPromotion: KindPromotion.DISCOUNT).save(flush: true)
      // Agregamos las promociones a los cursos calendarizados
      ScheduledCourse.list().each { sc ->
        sc.addToPromotions(new PromotionPerScheduledCourse(promotion: p1, validUntil: (new Date() + 30)))
        sc.addToPromotions(new PromotionPerScheduledCourse(promotion: p2, validUntil: (new Date() + 30)))
        sc.save()
      }
    }
  }

  def createScheduledCourses() {
    if (!ScheduledCourse.count()) {
      new ScheduledCourse(
          beginDate: (new Date() + 15),
          limitRegistrationDate: (new Date() + 10),
          costByCourse: 7000,
          costByModule: 2000,
          scheduledCourseStatus: ScheduledCourseStatus.SCHEDULED,
          course: Course.get(1L),
          durationInHours: 40
      ).save(flush: true)

      new ScheduledCourse(
          beginDate: (new Date() + 15),
          limitRegistrationDate: (new Date() + 10),
          costByCourse: 7000,
          costByModule: 2000,
          scheduledCourseStatus: ScheduledCourseStatus.SCHEDULED,
          course: Course.get(2L),
          durationInHours: 40
      ).save(flush: true)

      new ScheduledCourse(
          beginDate: (new Date() + 15),
          limitRegistrationDate: (new Date() + 10),
          costByCourse: 7000,
          costByModule: 2000,
          scheduledCourseStatus: ScheduledCourseStatus.SCHEDULED,
          course: Course.get(3L),
          durationInHours: 40
      ).save(flush: true)

      //Creamos sesiones para todos los cursos
      ScheduledCourse.list().each { scheduledCourse ->
        def begin = scheduledCourse.beginDate
        5.times {
          begin += 7
          courseSessionService.createSession4ScheduledCourse(scheduledCourse.id, begin)
        }
      }
    }
  }

  def createCourses() {
    if (!Course.count()) {
      new Course(
          name: 'Desarrollo profesional con Spring 3',
          content: '<p>Este es el contenido del curso</p>',
          contentType: ContentType.HTML,
          overview: "<p>Spring es una tecnología dedicada para permitir construir aplicaciones usando POJO’s….</p>",
          audience: "<p>Todos los desarrolladores Java</p>",
          prerequisites: "<p><ul><li>EJB</li><li>JDBC</li><li>Hibernate</li></ul></p>",
          goal: "<p>Entender los conceptos Inyección de dependencias e Inversión del Control </p>",
          method: "<p>Prácticos</p>",
          format: "<p>Formato del curso</p>",
          courseKey: "SPRING3.2011",
          urlLandingPage: "http://synergyj.com/spring",
          courseType: CourseType.COURSE,
          status: Status.LIVE,
          color: "",
          backgroundColor: "#204d20",
          borderColor: "#4d794d",
          textColor: "#cccc80"
      ).save(flush: true)

      new Course(
          name: 'Desarrollo Web Avanzado',
          content: '<p><ul><li>CSS y Javascript con jQuery</li><li>SpringMVC a profundidad</li><li>Flujos web con Spring WebFlow 2<br></li></ul></p>',
          contentType: ContentType.HTML,
          overview: "<p>En la actualidad, las aplicaciones web son la plataforma principal de muchos motores organizacionales, dandole la oportunidad a los usuarios de interactuar entre ellos con los datos de la operación.</p>",
          audience: "<p>Todos los desarrolladores Java</p>",
          prerequisites: "<p><ul><li>Servlets</li><li>JSP</li><li>MVC</li></ul></p>",
          goal: "<p>Desarrollar las habilidades necesarias para implementar un sitio web con funcionalidades atractivas</p>",
          method: "<p>Prácticos</p>",
          format: "<p>Formato del curso</p>",
          courseKey: "WEBADV.2011",
          urlLandingPage: "http://synergyj.com/wa",
          courseType: CourseType.COURSE,
          status: Status.LIVE,
          color: "",
          backgroundColor: "#990066",
          borderColor: "#bf609f",
          textColor: "#fbdbee"
      ).save(flush: true)

      new Course(
          name: 'Persistencia en Java con Hibernate',
          content: '<p><ul><li>Objetos persistentes</li><li>Transacciones</li><li>SessionFactory</li></ul></p>',
          contentType: ContentType.HTML,
          overview: "<p>La persistencia es importante, o no?</p>",
          audience: "<p>Todos los desarrolladores Java</p>",
          prerequisites: "<p><ul><li>BD</li><li>JSP</li><li>SQL</li></ul></p>",
          goal: "<p>Manejar Hibernate como se debe</p>",
          method: "<p>Prácticos</p>",
          format: "<p>Formato del curso</p>",
          courseKey: "HIBERNATE.2011",
          urlLandingPage: "http://synergyj.com/hibernate",
          courseType: CourseType.COURSE,
          status: Status.LIVE,
          color: "",
          backgroundColor: "#794d20",
          borderColor: "#c6b39f",
          textColor: "#ffecdf"
      ).save(flush: true)

    }
  }

  def createUsers() {
    // Correos de prueba
    def emails = ["user@mail.com", "user1@mail.com", "user2@mail.com", "user3@mail.com",
        "user4@mail.com", "user5@mail.com", "user6@mail.com", "user7@mail.com",
        "user8@mail.com", "user9@mail.com", "user10@mail.com"]

    if (!Role.count()) {
      def adminRole = new Role(authority: 'ROLE_ADMIN', description: 'Administrador').save(flush: true)
      def userRole = new Role(authority: 'ROLE_USER', description: 'Usuario').save(flush: true)
      log.debug "Roles creados ${adminRole},${userRole}"
      String password = 'password'
      log.debug("Creando usuarios de prueba y asignando roles")
      emails.each { mail ->
        def user = new User(email: mail, password: password).save(flush: true)
        PersonAuthority.create user, userRole, true
      }
      log.debug "Usuarios creados!!!"
      log.debug "Creando usuario administrador"
      def admin = new User(email: 'admin@admin.com', password: password).save(flush: true)
      PersonAuthority.create admin, adminRole, true
      log.debug "Usuario administrador creado y con roles asignados"
    }
  }

  def createReceipts() {
    // Para migración esto ocurre una vez, la primera vez
    if (!ReceiptAWS.count()) {
      // Obtenemos la lista de receipts de Payment
      def receipts = Receipt.list(fetch: [payment: 'eager'])
      // Iteramos los receipts
      receipts.each { receipt ->
        //  Usamos el servicio de S3Asset para crear el archivo
        def tmp = s3AssetService.getNewTmpLocalFile("image/jpeg")
        // Le asignamos los bytes de la BD
        tmp.bytes = receipt.image
        // Creamos la entidad persistente de AWS
        def receiptAWS = new ReceiptAWS()
        // Usamos el método del objeto con el archivo
        receiptAWS.newFile(tmp)
        // Establecemos sus propiedades
        receiptAWS.title = "Receipt for ${receipt.payment.transactionId}"
        receiptAWS.description = "Receipt for ${receipt.payment.amount}"
        receiptAWS.mimeType = "image/jpeg"
        receiptAWS.receiptStatus = receipt.receiptStatus
        // Creamos la relación
        receiptAWS.payment = receipt.payment
        s3AssetService.put(receiptAWS)
      }
    }
  }

  def destroy = {
  }
} 