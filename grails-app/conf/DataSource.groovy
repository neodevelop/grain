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
dataSource {
    pooled = true
    driverClassName = "org.hsqldb.jdbcDriver"
    username = "sa"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
      url = "jdbc:mysql://localhost/grain"
      driverClassName = "com.mysql.jdbc.Driver"
      username = "root"
      password = "mysql91"
			dbCreate = "update" // one of 'create', 'create-drop','update'
		}
    hibernate {
      show_sql = false
      format_sql = true
    }
	}
	test {
		dataSource {
			dbCreate = "create"
			url = "jdbc:hsqldb:mem:testDB"
		}
	}
	production {
		dataSource {
			pooled = true
      dbCreate = "update"
      url = "jdbc:mysql://localhost/grain"
      driverClassName = "com.mysql.jdbc.Driver"
      username = "root"
      password = ""
		}
	}
}