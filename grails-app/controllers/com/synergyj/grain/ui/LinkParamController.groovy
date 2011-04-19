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

//@Secured(["hasRole('ROLE_ADMIN')"])
class LinkParamController {

  def index = { redirect(action: "list", params: params) }

  // the delete, save and update actions only accept POST requests
  static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

  def list = {
    params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
    [linkParamInstanceList: LinkParam.list(params), linkParamInstanceTotal: LinkParam.count()]
  }

  def create = {
    def linkParamInstance = new LinkParam()
    linkParamInstance.properties = params
    return [linkParamInstance: linkParamInstance]
  }

  def save = {
    def linkParamInstance = new LinkParam(params)
    if (!linkParamInstance.hasErrors() && linkParamInstance.save()) {
      flash.message = "linkParam.created"
      flash.args = [linkParamInstance.id]
      flash.defaultMessage = "LinkParam ${linkParamInstance.id} created"
      redirect(action: "show", id: linkParamInstance.id)
    }
    else {
      render(view: "create", model: [linkParamInstance: linkParamInstance])
    }
  }

  def show = {
    def linkParamInstance = LinkParam.get(params.id)
    if (!linkParamInstance) {
      flash.message = "linkParam.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "LinkParam not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [linkParamInstance: linkParamInstance]
    }
  }

  def edit = {
    def linkParamInstance = LinkParam.get(params.id)
    if (!linkParamInstance) {
      flash.message = "linkParam.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "LinkParam not found with id ${params.id}"
      redirect(action: "list")
    }
    else {
      return [linkParamInstance: linkParamInstance]
    }
  }

  def update = {
    def linkParamInstance = LinkParam.get(params.id)
    if (linkParamInstance) {
      if (params.version) {
        def version = params.version.toLong()
        if (linkParamInstance.version > version) {

          linkParamInstance.errors.rejectValue("version", "linkParam.optimistic.locking.failure", "Another user has updated this LinkParam while you were editing")
          render(view: "edit", model: [linkParamInstance: linkParamInstance])
          return
        }
      }
      linkParamInstance.properties = params
      if (!linkParamInstance.hasErrors() && linkParamInstance.save()) {
        flash.message = "linkParam.updated"
        flash.args = [params.id]
        flash.defaultMessage = "LinkParam ${params.id} updated"
        redirect(action: "show", id: linkParamInstance.id)
      }
      else {
        render(view: "edit", model: [linkParamInstance: linkParamInstance])
      }
    }
    else {
      flash.message = "linkParam.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "LinkParam not found with id ${params.id}"
      redirect(action: "edit", id: params.id)
    }
  }

  def delete = {
    def linkParamInstance = LinkParam.get(params.id)
    if (linkParamInstance) {
      try {
        linkParamInstance.delete()
        flash.message = "linkParam.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "LinkParam ${params.id} deleted"
        redirect(action: "list")
      }
      catch (org.springframework.dao.DataIntegrityViolationException e) {
        flash.message = "linkParam.not.deleted"
        flash.args = [params.id]
        flash.defaultMessage = "LinkParam ${params.id} could not be deleted"
        redirect(action: "show", id: params.id)
      }
    }
    else {
      flash.message = "linkParam.not.found"
      flash.args = [params.id]
      flash.defaultMessage = "LinkParam not found with id ${params.id}"
      redirect(action: "list")
    }
  }
}
