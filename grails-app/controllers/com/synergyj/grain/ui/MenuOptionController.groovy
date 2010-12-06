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

class MenuOptionController {

  def index = { redirect(action: "list", params: params) }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [menuOptionInstanceList: MenuOption.list(params), menuOptionInstanceTotal: MenuOption.count()]
  }

  def create = {
    def menuOptionInstance = new MenuOption()
    menuOptionInstance.properties = params
    return [menuOptionInstance: menuOptionInstance]
  }

  def save = {
    def menuOptionInstance = new MenuOption(params)
    if (!menuOptionInstance.hasErrors() && menuOptionInstance.save()) {
      flash.message = "menuOption.created"
      flash.args = [menuOptionInstance.id]
      flash.defaultMessage = "MenuOption ${menuOptionInstance.id} created"
      redirect(action: "show", id: menuOptionInstance.id)
    }
    else {
      render(view: "create", model: [menuOptionInstance: menuOptionInstance])
    }
  }

  def show = {
    def menuOptionInstance = MenuOption.get(params.id)
    if (!menuOptionInstance) {
      flash.message = "menuOption.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "MenuOption not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [menuOptionInstance: menuOptionInstance]
    }
  }

  def edit = {
    def menuOptionInstance = MenuOption.get(params.id)
    if (!menuOptionInstance) {
      flash.message = "menuOption.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "MenuOption not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [menuOptionInstance: menuOptionInstance]
    }
  }

  def update = {
    def menuOptionInstance = MenuOption.get(params.id)
    if (menuOptionInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (menuOptionInstance.version > version) {

          menuOptionInstance.errors.rejectValue("version", "menuOption.optimistic.locking.failure", "Another user has updated this MenuOption while you were editing")
          render(view: "edit", model: [menuOptionInstance: menuOptionInstance])
          return
        }
      }
      menuOptionInstance.properties = params
      if (!menuOptionInstance.hasErrors() && menuOptionInstance.save()) {
        flash.message = "menuOption.updated"
        flash.args = [params.id]
        flash.defaultMessage = "MenuOption ${params.id} updated"
        redirect(action: "show", id: menuOptionInstance.id)
      }
      else {
        render(view: "edit", model: [menuOptionInstance: menuOptionInstance])
      }
    }
    else {
      flash.message = "menuOption.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "MenuOption not found with id ${params.id}"
      redirect(action: "edit", id: params.id)
    }
  }

  def delete = {
    def menuOptionInstance = MenuOption.get(params.id)
    if (menuOptionInstance) {
      try {
        menuOptionInstance.delete()
        flash.message = "menuOption.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "MenuOption ${params.id} deleted"
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "menuOption.not.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "MenuOption ${params.id} could not be deleted"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "menuOption.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "MenuOption not found with id ${params.id}"
      redirect(action: "list")
    }
  }
}
