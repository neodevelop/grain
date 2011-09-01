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
import java.text.DecimalFormat
import java.text.DecimalFormatSymbols
import org.springframework.beans.propertyeditors.CustomNumberEditor
import java.text.SimpleDateFormat
import org.springframework.beans.propertyeditors.CustomDateEditor
import org.springframework.beans.PropertyEditorRegistry
import org.springframework.beans.PropertyEditorRegistrar

class GlobalPropertyEditorConfig implements PropertyEditorRegistrar{

  public void registerCustomEditors(PropertyEditorRegistry propertyEditorRegistry) {
    def numberFormat = new DecimalFormat("#,##0.##", new DecimalFormatSymbols(new Locale('es','MX')))
    propertyEditorRegistry.registerCustomEditor(BigDecimal.class, new CustomNumberEditor(BigDecimal.class, numberFormat, true))

    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yy HH:mm")
		dateFormat.setLenient(false)
		propertyEditorRegistry.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
  }

}
