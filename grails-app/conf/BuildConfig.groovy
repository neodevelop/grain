grails.project.plugins.dir = "${userHome}/.grails/plugins"
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
//grails.project.war.file = "target/${appName}-${appVersion}.war"
grails.project.dependency.resolution = {
  // inherit Grails' default dependencies
  inherits("global") {
    // uncomment to disable ehcache
    // excludes 'ehcache'
  }
  log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
  repositories {
    grailsPlugins()
    grailsHome()
    grailsCentral()
    mavenCentral()
  }

  plugins {
    runtime 'org.grails.plugins:spring-security-core:1.0.1'
    runtime 'org.grails.plugins:tiny-mce:0.1.3'
    runtime 'org.grails.plugins:mail:0.9'
    runtime 'org.grails.plugins:settings:1.4'
    runtime 'org.grails.plugins:jquery:1.4.3.2'

    test 'org.grails.plugins:code-coverage:1.2'
    test 'org.grails.plugins:codenarc:0.8'
    test 'org.grails.plugins:gmetrics:0.3'
    test 'org.grails.plugins:geb:0.5.1'
    test 'org.grails.plugins:spock:0.5-groovy-1.7'
  }

  dependencies {
    runtime 'mysql:mysql-connector-java:5.1.13'

    test('org.seleniumhq.selenium:selenium-htmlunit-driver:2.0a7') {
      exclude 'xml-apis'
    }
  }

}
