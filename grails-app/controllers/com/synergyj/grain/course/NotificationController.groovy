package com.synergyj.grain.course

class NotificationController {

    def index = {
      render(view:params.mailView ?: 'registration')
    }
}
