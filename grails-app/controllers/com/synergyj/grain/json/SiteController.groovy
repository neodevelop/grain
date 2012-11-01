package com.synergyj.grain.json

import grails.converters.JSON;

import com.synergyj.grain.course.ScheduledCourse;
import com.synergyj.grain.course.ScheduledCourseStatus;

class SiteController {

    def index = { }
    
    
    def getScheduledCourses = {
      def scheduledCourses = ScheduledCourse.findAllByScheduledCourseStatus(ScheduledCourseStatus.SCHEDULED)
      def mapa = [:]
      def courseList =[]
      
      if (scheduledCourses.size() > 0) {
        mapa['existen']=true
        scheduledCourses.each { scheduledCourse -> 
          def dia = scheduledCourse.beginDate.format('EEEE')
          def fecha = scheduledCourse.beginDate.format('MMM  dd yyyy')
          def horario = scheduledCourse.courseSessions.toArray()[0].sessionStartTime.format('HH:mm') + " a " +
          scheduledCourse.courseSessions.toArray()[0].sessionEndTime.format('HH:mm')
          
          def courseData = new CourseData(name: scheduledCourse.course.name ,dateOfWeek: dia , 
                initialDate: fecha, duration:scheduledCourse.durationInHours + " horas", 
                urlCourse: scheduledCourse.course.urlLandingPage , sessionTime: horario )
          courseList << courseData
        } 
        mapa['lista']=courseList 
        
      }  else {
        mapa['existen']=false
      }
      
      response.setHeader('Access-Control-Allow-Origin', "*")
      
      render mapa as JSON
    }
}

class CourseData {
  
  def name
  def initialDate
  def duration
  def dateOfWeek
  def urlCourse
  def sessionTime
}
