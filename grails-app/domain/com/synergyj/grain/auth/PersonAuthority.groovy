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

import org.apache.commons.lang.builder.HashCodeBuilder

class PersonAuthority implements Serializable {

  User user
  Role role

  boolean equals(other) {
    if (!(other instanceof PersonAuthority)) {
      return false
    }

    other.user?.id == user?.id &&
        other.role?.id == role?.id
  }

  int hashCode() {
    def builder = new HashCodeBuilder()
    if (user) builder.append(user.id)
    if (role) builder.append(role.id)
    builder.toHashCode()
  }

  static PersonAuthority get(long userId, long roleId) {
    find 'from PersonAuthority where user.id=:userId and role.id=:roleId',
        [userId: userId, roleId: roleId]
  }

  static PersonAuthority create(User user, Role role, boolean flush = false) {
    new PersonAuthority(user: user, role: role).save(flush: flush, insert: true)
  }

  static boolean remove(User user, Role role, boolean flush = false) {
    PersonAuthority instance = UserRole.findByUserAndRole(user, role)
    instance ? instance.delete(flush: flush) : false
  }

  static void removeAll(User user) {
    executeUpdate 'DELETE FROM PersonAuthority WHERE user=:user', [user: user]
  }

  static mapping = {
    id composite: ['role', 'user']
    version false
    table 'gr_person_roles'
  }
}
