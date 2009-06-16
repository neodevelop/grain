/*
 * Copyright 2002-2008 the original author or authors.
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
package com.synergyj.grain.auth

class User {
	static transients = ['pass']
	static hasMany = [roles:Role]
	static belongsTo = Role
	
	
	Date dateCreated
	Date lastUpdated
	String email
	String username
	String passwd
	String userRealName
	Boolean enabled = true
	String description
	String company
	String blog
	String geolocation
	String site
	boolean emailShow
	
	/** plain password to create a MD5 password */
	String pass = '[secret]'

	static constraints = {
		email        nullable:false, blank:false, size:1..200, unique:true,email:true
		username     nullable:false, blank:false, size:3..25,  unique:true
		passwd       nullable:false, blank:false, size:5..25
		userRealName nullable:false, blank:false, size:0..200
		company      nullable:true,  blank:true,  size:0..100
		geolocation  nullable:true,  blank:true,  size:0..200
		description  nullable:true,  blank:true,  size:0..1000
		blog         nullable:true,  blank:true,  size:0..300, url:true
		site         nullable:false, blank:false, size:1..20,  url:true
		lastUpdated  display:false
		dateCreated  display:false
		//geolocation(nullable:true,blank:true,size:0..200,geolocation:true)
	}

	static mapping = {
		cache true
		table 'users'
    }

	String toString() {
		username
	}
}
