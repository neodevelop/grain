/*
 * Copyright 2002-2010 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.synergyj.grain.ui

import grails.plugins.springsecurity.Secured

@Secured(["hasRole('ROLE_ADMIN')"])
class MenuController {

  def index = { redirect(action: "list", params: params) }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [menuInstanceList: Menu.list(params), menuInstanceTotal: Menu.count()]
  }

  def create = {
    def menuInstance = new Menu()
    menuInstance.properties = params
    return [menuInstance: menuInstance]
  }

  def save = {
    def menuInstance = new Menu(params)
    if (!menuInstance.hasErrors() && menuInstance.save()) {
      flash.message = "menu.created"
      flash.args = [menuInstance.id]
      flash.defaultMessage = "Menu ${menuInstance.id} created"
      redirect(action: "show", id: menuInstance.id)
    }
    else {
      render(view: "create", model: [menuInstance: menuInstance])
    }
  }

  def show = {
    def menuInstance = Menu.get(params.id)
    if (!menuInstance) {
      flash.message = "menu.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "Menu not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [menuInstance: menuInstance]
    }
  }

  def edit = {
    def menuInstance = Menu.get(params.id)
    if (!menuInstance) {
      flash.message = "menu.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "Menu not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [menuInstance: menuInstance]
    }
  }

  def update = {
    def menuInstance = Menu.get(params.id)
    if (menuInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (menuInstance.version > version) {

          menuInstance.errors.rejectValue("version", "menu.optimistic.locking.failure", "Another user has updated this Menu while you were editing")
          render(view: "edit", model: [menuInstance: menuInstance])
          return
        }
      }
      menuInstance.properties = params
      if (!menuInstance.hasErrors() && menuInstance.save()) {
        flash.message = "menu.updated"
        flash.args = [params.id]
        flash.defaultMessage = "Menu ${params.id} updated"
        redirect(action: "show", id: menuInstance.id)
      }
      else {
        render(view: "edit", model: [menuInstance: menuInstance])
      }
    }
    else {
      flash.message = "menu.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "Menu not found with id ${params.id}"
      redirect(action: "edit", id: params.id)
    }
  }

  def delete = {
    def menuInstance = Menu.get(params.id)
    if (menuInstance) {
      try {
        menuInstance.delete()
        flash.message = "menu.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "Menu ${params.id} deleted"
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "menu.not.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "Menu ${params.id} could not be deleted"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "menu.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "Menu not found with id ${params.id}"
      redirect(action: "list")
    }
  }
}
