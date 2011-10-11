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
package com.synergyj.grain

import com.synergyj.grain.course.ReceiptAWS

class S3AssetJob {
  static triggers = {
    cron name: 's3AssetTrigger', cronExpression: "0 0/15 * * * ?"
  }

  def group = "S3AssetGroup"

  def execute() {
    log.debug "Borrando los assets con status error y removed"
    def thereIsReceipts = ReceiptAWS.countByStatusInList([ReceiptAWS.STATUS_ERROR,ReceiptAWS.STATUS_REMOVED])
    if(thereIsReceipts){
      ReceiptAWS.executeUpdate("delete from ReceiptAWS r where r.status in(?,?)",[ReceiptAWS.STATUS_ERROR,ReceiptAWS.STATUS_REMOVED])
      log.debug "hay recibos para borrar"
    }
  }
}
