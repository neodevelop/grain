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
package com.synergyj.grain.course

public enum RegistrationStatus {
  REGISTERED("registration.registered.no.group"),
  INSCRIBED_AND_WITH_DEBTH("registration.inscribed.with.debt"),
  INSCRIBED_AND_WITH_DEBTH_IN_GROUP("registration.inscribed.with.debt.in.group"),
  INSCRIBED_AND_PAYED("registration.inscribed.payed"),
  INSCRIBED_AND_PAYED_IN_GROUP("registration.inscribed.payed.in.group"),
  FINISHED("registration.finished"),
  CANCELLED("registration.cancelled")

  private final String code

  RegistrationStatus(String code){
    this.code = code
  }

  public String getCode(){ return this.code }
}