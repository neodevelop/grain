package com.synergyj.grain.event

class NotificationController {

    def index = {
      render(view:params.mailView ?: 'registration')
    }
}
