package com.synergyj.grain.trainning

import grails.plugins.springsecurity.Secured

@Secured(["hasRole('ROLE_ADMIN')"])
class TrainningController {

    def index = { }
}
