package com.synergyj.grain.course

import grails.test.*
import com.synergyj.grain.auth.User

class RegistrationServiceTests extends GrailsUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testAddUserToScheduledCourse() {
      def user = new User(email:'user@user.com',password:password)
      mockDomain(User,[user])
      def scheduledCourse = new ScheduledCourse(id:1)
      mockDomain(ScheduledCourse,[scheduledCourse])
      // TODO: probar los casos
    }
}
