modules = {
  home {
    resource url:'/css/grain.css'
  }
  overrides { // Arreglando bootstra-fixtaglib.css
    'bootstrap-fixtaglib' {
      defaultBundle 'fixtaglib'
    }   
  } // https://github.com/groovydev/twitter-bootstrap-grails-plugin/issues/32
}