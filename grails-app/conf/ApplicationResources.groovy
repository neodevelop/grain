modules = {
  home {
    resource url:'/css/grain.css'
  }
  payment {
    resource url:'/js/payment/index.js'
  }
  overrides { // Arreglando bootstra-fixtaglib.css
    'bootstrap-fixtaglib' {
      defaultBundle 'fixtaglib'
    }   
  } // https://github.com/groovydev/twitter-bootstrap-grails-plugin/issues/32
  images {
    resource url:'/images/spinner.gif'
  }
}