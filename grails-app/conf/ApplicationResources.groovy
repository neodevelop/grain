modules = {
  common {
    resource url:'/css/grain.css'
  }
  paginator {
    resource url:'/js/common/paginator.js'
  }
  home{
    resource url:'/js/home/home.js'
  }
  payment {
    resource url:'/js/payment/index.js'
  }
  paymentForCurrentUser {
    resource url:'/js/payment/forCurrentUser.js'
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
    resource url:'/images/ico.gif'
    resource url:'/images/ico.png'
  }
  overrides {
    'jquery-theme'{
      resource id:'theme', url:'http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.11/themes/cupertino/jquery-ui.css'
    }
  }
}