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

    // from public Maven repositories
    mavenLocal()
    mavenCentral()

    mavenRepo "http://maven.springframework.org/release"
    mavenRepo "http://maven.springframework.org/snapshot"
    mavenRepo "http://maven.springframework.org/milestone"

    grailsRepo "http://grails.org/plugins"
  }

  dependencies {
    runtime 'mysql:mysql-connector-java:5.1.13'
  }

  plugins {
    compile ":hibernate:$grailsVersion"
    runtime ":jquery:1.7.1"
    compile ":jquery-ui:1.8.15"
    runtime ":resources:1.1.6"
    compile ":twitter-bootstrap:2.0.2.25"
    build ":tomcat:$grailsVersion"

    runtime ":zipped-resources:1.0"
    runtime ":cached-resources:1.0"
    runtime ":yui-minify-resources:0.1.4"
    compile ":cache-headers:1.1.5"

    compile ":spring-security-core:1.2.7.3"
    compile ":spring-security-ui:0.2"
    runtime 'org.grails.plugins:famfamfam:1.0.1'
    compile ":mail:1.0"
    runtime 'org.grails.plugins:settings:1.4'
    runtime 'org.grails.plugins:avatar:0.5'
    runtime 'org.grails.plugins:google-analytics:1.0'
    runtime 'org.grails.plugins:jasper:1.2.1'
    runtime 'org.grails.plugins:rabbitmq:0.3.2'
    compile ":quartz:0.4.2"
    runtime ':grails-melody:1.7'
    runtime ':amazon-s3:0.8.2'
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
