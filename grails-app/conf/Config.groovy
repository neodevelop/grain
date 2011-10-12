import org.apache.log4j.DailyRollingFileAppender

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

// locations to search for config files that get merged into the main config
// config files can either be Java properties files or ConfigSlurper scripts

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if(System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination
grails.mime.file.extensions = true // enables the parsing of file extensions from URLs into the request format
grails.mime.use.accept.header = false
grails.mime.types = [
    html: ['text/html', 'application/xhtml+xml'],
    xml: ['text/xml', 'application/xml'],
    text: 'text/plain',
    js: 'text/javascript',
    rss: 'application/rss+xml',
    atom: 'application/atom+xml',
    css: 'text/css',
    csv: 'text/csv',
    pdf: 'application/pdf',
    all: '*/*',
    json: ['application/json', 'text/json'],
    form: 'application/x-www-form-urlencoded',
    multipartForm: 'multipart/form-data'
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// The default codec used to encode data with ${}
grails.views.default.codec = "none" // none, html, base64
grails.views.gsp.encoding = "UTF-8"
grails.converters.encoding = "UTF-8"
// enable Sitemesh preprocessing of GSP pages
grails.views.gsp.sitemesh.preprocess = true
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// whether to install the java.util.logging bridge for sl4j. Disable for AppEngine!
grails.logging.jul.usebridge = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []

grails.views.javascript.library = "jquery"
jqueryUi.cdn = 'googlecode'

// set per-environment serverURL stem for creating absolute links
def logDirectory = "target/" // Directorio de Log4J
def theBucketName = "dev"
environments {
  development {
    grails.serverURL = "http://localhost:8080/grain"
    theBucketName = "dev"
  }
  test {
    grails.serverURL = "http://localhost:8080/${appName}"
    grails.plugins.springsecurity.portMapper.httpPort = 80 // Spring Security Config
    grails.plugins.springsecurity.portMapper.httpsPort = 80 // Spring Security Config
    theBucketName = "test"
  }
  production {
    grails.serverURL = "http://entrenamiento.synergyj.com"
    logDirectory = "logs/" // Directorio de Log4J
    grails.plugins.springsecurity.portMapper.httpPort = 80 // Spring Security Config
    grails.plugins.springsecurity.portMapper.httpsPort = 443 // Spring Security Config
    theBucketName = "prod"
  }
}

log4j = {

  appenders {
    console name: 'stdout', layout: pattern(conversionPattern: '%d{ISO8601}\t%p\t%c:%L\t%m%n'), threshold: org.apache.log4j.Level.ERROR
    appender new DailyRollingFileAppender(name: 'file', file: logDirectory + 'grain.log',
        datePattern: '\'_\'yyyy-MM-dd', layout: pattern(conversionPattern: '%d{ISO8601}\t%p\t%c:%L\t%m%n'))
  }

  root {
    debug 'stdout', 'file'
    additivity = true
  }

  debug 'grails.app.controllers.com.synergyj',
      'grails.app.taglib.com.synergyj',
      'grails.app.services.com.synergyj',
      'grails.app.domain.com.synergyj',
      'grails.app.conf',
      'grails.app.jobs.com.synergyj.grain',
      'groovyx'

  warn 'org.codehaus.groovy.grails.web.servlet',  //  controllers
      'org.codehaus.groovy.grails.web.pages', //  GSP
      'org.codehaus.groovy.grails.web.sitemesh', //  layouts
      'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
      'org.codehaus.groovy.grails.web.mapping', // URL mapping
      'org.codehaus.groovy.grails.commons', // core / classloading
      'org.codehaus.groovy.grails.plugins', // plugins
      'org.codehaus.groovy.grails.orm.hibernate', // hibernate integration
      'org.codehaus',
      'org.springframework',
      'org.hibernate',
      'org.mortbay.log',
      'net.sf',
      'org.terracotta',
      'org.quartz',
      'org.apache',
      'net.bull',
      'grails.spring',
      'net.sf.ehcache.hibernate',
      'org.grails.tomcat'

  error 'net.sf.ehcache', 'net.sf.ehcache.hibernate', 'org.hibernate'

  environments {
    production {
      // Override previous setting
      error "grails",
          "org",
          "net",
          "com",
          "groovyx",
          "net.bull.javamelody",
          "httpclient"
    }
  }

}

grails.plugins.springsecurity.userLookup.userDomainClassName = 'com.synergyj.grain.auth.User'
grails.plugins.springsecurity.userLookup.usernamePropertyName = 'email'
grails.plugins.springsecurity.userLookup.authorityJoinClassName = 'com.synergyj.grain.auth.PersonAuthority'
grails.plugins.springsecurity.authority.className = 'com.synergyj.grain.auth.Role'
grails.plugins.springsecurity.rememberMe.cookieName = 'grain_remember_me'
grails.plugins.springsecurity.rememberMe.key = 'gHUaaSP3456X9S3hTjskQ'
grails.plugins.springsecurity.rememberMe.persistentToken.domainClassName = 'com.synergyj.grain.auth.PersistentLogin'
grails.plugins.springsecurity.rememberMe.persistent = true
grails.plugins.springsecurity.rememberMe.alwaysRemember = true
grails.plugins.springsecurity.errors.login.fail = "security.login.fail"
grails.plugins.springsecurity.errors.login.expired = "security.login.expired"
grails.plugins.springsecurity.errors.login.passwordExpired = "security.login.passwordExpired"
grails.plugins.springsecurity.errors.login.disabled = "security.login.disabled"
grails.plugins.springsecurity.errors.login.locked = "security.login.locked"
grails.plugins.springsecurity.dao.reflectionSaltSourceProperty = 'username'
grails.plugins.springsecurity.useSessionFixationPrevention = true
grails.plugins.springsecurity.successHandler.defaultTargetUrl = '/me'

grails.plugins.springsecurity.controllerAnnotations.staticRules = [
    '/themes/**': ['permitAll'],
    '/js/**': ['permitAll'],
    '/images/**': ['permitAll'],
    '/plugins/**': ['permitAll'],
    '/logout/**': ['IS_AUTHENTICATED_ANONYMOUSLY'],
    '/monitoring/**': ["hasRole('ROLE_ADMIN')"],
    '/s3Asset/**': ["hasRole('ROLE_ADMIN')"]
]

// Temporalmente agregado para usar el flujo de registro
grails {
  mail {
    host = "smtp.gmail.com"
    port = 465
    username = "cursos@synergyj.com"
    password = ""
    props = ["mail.smtp.auth": "true",
        "mail.smtp.socketFactory.port": "465",
        "mail.smtp.socketFactory.class": "javax.net.ssl.SSLSocketFactory",
        "mail.smtp.socketFactory.fallback": "false"]
  }
}

avatarPlugin {
  defaultGravatarUrl = """http://synergyj.com/user_anonymous.png"""
  gravatarRating = "G"
}

google.analytics.webPropertyID = "UA-xxxxxx-x"

tomcat.deploy.username = "tomcat"
tomcat.deploy.password = "secret"
tomcat.deploy.url = "http://localhost:8080/manager/text"

rabbitmq {
  connectionfactory {
    username = 'guest'
    password = 'guest'
    hostname = 'localhost'
  }
  queues = {
    grain_mail_notification()
  }
}

aws {
  domain="s3.amazonaws.com"
  accessKey=""
  secretKey=""
  bucketName="media.grain.com.${theBucketName}"
  prefixBucketWithKey=false
  lazyInit=true
  // Le damos u plazo de 10 minutos entre intervalos para que sincronice
  startDelay=1000*60*10
  timeout=1000*60*10
}