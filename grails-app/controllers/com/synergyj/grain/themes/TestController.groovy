package com.synergyj.grain.themes

import grails.plugins.springsecurity.Secured

@Secured(['permitAll'])
class TestController {
  def index = { }
  def content = {}
}
