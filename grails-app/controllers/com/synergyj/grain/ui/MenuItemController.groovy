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

class MenuItemController {

  def index = { redirect(action: "list", params: params) }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [menuItemInstanceList: MenuItem.list(params), menuItemInstanceTotal: MenuItem.count()]
  }

  def create = {
    def menuItemInstance = new MenuItem()
    menuItemInstance.properties = params
    return [menuItemInstance: menuItemInstance]
  }

  def save = {
    def menuItemInstance = new MenuItem(params)
    if (!menuItemInstance.hasErrors() && menuItemInstance.save()) {
      flash.message = "menuItem.created"
      flash.args = [menuItemInstance.id]
      flash.defaultMessage = "MenuItem ${menuItemInstance.id} created"
      redirect(action: "show", id: menuItemInstance.id)
    }
    else {
      render(view: "create", model: [menuItemInstance: menuItemInstance])
    }
  }

  def show = {
    def menuItemInstance = MenuItem.get(params.id)
    if (!menuItemInstance) {
      flash.message = "menuItem.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "MenuItem not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [menuItemInstance: menuItemInstance]
    }
  }

  def edit = {
    def menuItemInstance = MenuItem.get(params.id)
    if (!menuItemInstance) {
      flash.message = "menuItem.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "MenuItem not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [menuItemInstance: menuItemInstance]
    }
  }

  def update = {
    def menuItemInstance = MenuItem.get(params.id)
    if (menuItemInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (menuItemInstance.version > version) {

          menuItemInstance.errors.rejectValue("version", "menuItem.optimistic.locking.failure", "Another user has updated this MenuItem while you were editing")
          render(view: "edit", model: [menuItemInstance: menuItemInstance])
          return
        }
      }
      menuItemInstance.properties = params
      if (!menuItemInstance.hasErrors() && menuItemInstance.save()) {
        flash.message = "menuItem.updated"
        flash.args = [params.id]
        flash.defaultMessage = "MenuItem ${params.id} updated"
        redirect(action: "show", id: menuItemInstance.id)
      }
      else {
        render(view: "edit", model: [menuItemInstance: menuItemInstance])
      }
    }
    else {
      flash.message = "menuItem.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "MenuItem not found with id ${params.id}"
      redirect(action: "edit", id: params.id)
    }
  }

  def delete = {
    def menuItemInstance = MenuItem.get(params.id)
    if (menuItemInstance) {
      try {
        menuItemInstance.delete()
        flash.message = "menuItem.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "MenuItem ${params.id} deleted"
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "menuItem.not.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "MenuItem ${params.id} could not be deleted"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "menuItem.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "MenuItem not found with id ${params.id}"
      redirect(action: "list")
    }
  }
}
