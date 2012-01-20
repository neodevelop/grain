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

  dependencies {
    test("org.seleniumhq.selenium:selenium-htmlunit-driver:2.16.1") {
      excludes 'xml-apis', 'xercesImpl', 'xmlParserAPIs' // Exclusiones cruciales
    }
    test("org.seleniumhq.selenium:selenium-chrome-driver:2.16.1")
    test("org.seleniumhq.selenium:selenium-firefox-driver:2.16.1")
    test "org.codehaus.geb:geb-spock:0.6.2"
    runtime 'mysql:mysql-connector-java:5.1.13'
  }

  plugins {
    compile ":hibernate:$grailsVersion"
    runtime ":jquery:1.6.1.1"
    //compile ":resources:1.0.2"

    build ":tomcat:$grailsVersion"

    runtime 'org.grails.plugins:spring-security-core:1.2'
    runtime 'org.grails.plugins:spring-security-ui:0.1.2'
    runtime 'org.grails.plugins:famfamfam:1.0.1'
    runtime 'org.grails.plugins:mail:1.0-SNAPSHOT'
    runtime 'org.grails.plugins:settings:1.4'
    runtime 'org.grails.plugins:jquery-ui:1.8.11'
    runtime 'org.grails.plugins:avatar:0.5'
    runtime 'org.grails.plugins:google-analytics:1.0'
    runtime 'org.grails.plugins:jasper:1.2.1'
    runtime 'org.grails.plugins:rabbitmq:0.3.2'
    runtime 'org.grails.plugins:quartz:0.4.2'
    runtime ':grails-melody:1.7'
    runtime ':amazon-s3:0.8.2'
    test ":geb:0.6.2"
    test ":spock:0.5-groovy-1.7"
    //runtime 'org.grails.plugins:jquery-validation:1.7'
    //runtime 'org.grails.plugins:jquery-validation-ui:1.1'
    //runtime 'org.grails.plugins:constraints:0.5.1'
    //test 'org.grails.plugins:code-coverage:1.2'
    //test 'org.grails.plugins:codenarc:0.8.1'
    //test 'org.grails.plugins:gmetrics:0.3'
    //test 'org.grails.plugins:geb:0.5.1'
    //test 'org.grails.plugins:spock:0.5-groovy-1.7'
  }

}
