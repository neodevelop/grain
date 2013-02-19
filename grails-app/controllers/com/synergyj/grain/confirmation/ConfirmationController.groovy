package com.synergyj.grain.confirmation

import com.synergyj.grain.course.ScheduledCourse


class ConfirmationController {
  
    def grailsApplication

    def index = { 
      redirect action: subscribeCourse, params: params
    }
    
 
    def subscribeCourse ={
      def id = params.long('id')
      def scheduledCourse = ScheduledCourse.get(id)
      [ id :id,  scheduledCourse: scheduledCourse, url: grailsApplication.config.grails.serverURL]
    }
    
}
