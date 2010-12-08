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

import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUser
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUserDetailsService
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.security.core.authority.GrantedAuthorityImpl
import org.springframework.security.core.userdetails.UserDetails
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.security.core.GrantedAuthority

class GrainUserDetailsService implements GrailsUserDetailsService {

  /**
   * Some Spring Security classes (e.g. RoleHierarchyVoter) expect at least one role, so
   * we give a user with no granted roles this one which gets past that restriction but
   * doesn't grant anything.
   */
  static final List NO_ROLES = [new GrantedAuthorityImpl(SpringSecurityUtils.NO_ROLE)]

  UserDetails loadUserByUsername(String username, boolean loadRoles)
  throws UsernameNotFoundException {
    return loadUserByUsername(username)
  }

  UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {

    User.withTransaction { status ->

      User user = User.findByEmail(userName)
      if (!user) throw new UsernameNotFoundException('User not found', userName)

      def conf = SpringSecurityUtils.securityConfig

      String usernamePropertyName = conf.userLookup.usernamePropertyName
      String passwordPropertyName = conf.userLookup.passwordPropertyName
      String enabledPropertyName = conf.userLookup.enabledPropertyName
      String accountExpiredPropertyName = conf.userLookup.accountExpiredPropertyName
      String accountLockedPropertyName = conf.userLookup.accountLockedPropertyName
      String passwordExpiredPropertyName = conf.userLookup.passwordExpiredPropertyName

      String username = user."$usernamePropertyName"
      String password = user."$passwordPropertyName"
      boolean enabled = enabledPropertyName ? user."$enabledPropertyName" : true
      boolean accountExpired = accountExpiredPropertyName ? user."$accountExpiredPropertyName" : false
      boolean accountLocked = accountLockedPropertyName ? user."$accountLockedPropertyName" : false
      boolean passwordExpired = passwordExpiredPropertyName ? user."$passwordExpiredPropertyName" : false

      def authorities = loadAuthorities(user, userName, loadRoles).findAll {it != null}  ?: NO_ROLES

      return new GrainUserDetails(username, password, enabled, !accountExpired, !passwordExpired, !accountLocked,
            authorities, user.id)
    }
  }
}
