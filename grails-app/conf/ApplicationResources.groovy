modules = {
  common {
    resource url:'/css/grain.css'
  }
  home{
    resource url:'/js/home/jquery.timer.js'
    resource url:'/js/home/home.js'
  }
  payment {
    resource url:'/js/payment/index.js'
  }
  me {
    resource url:'/js/user/me.js'
  }
  overrides { // Arreglando bootstra-fixtaglib.css
    'bootstrap-fixtaglib' {
      defaultBundle 'fixtaglib'
    }   
  } // https://github.com/groovydev/twitter-bootstrap-grails-plugin/issues/32
  images {
    resource url:'/images/spinner.gif'
    resource url:'/images/7-eleven-icon.png'
    resource url:'/images/amex-icon.png'
    resource url:'/images/banorte-icon.png'
    resource url:'/images/mastercard-icon.gif'
    resource url:'/images/oxxo-icon.gif'
    resource url:'/images/visa-icon.gif'
    resource url:'/images/banner1.jpg'
  }
}