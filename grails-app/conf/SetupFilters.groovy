import com.synergyj.grain.auth.*

class SetupFilters {
	def filters = {
		all(controller:'*', action:'*') {
			before = {
				if(User.count() == 0) {
					println "No hay usuarios"
				}
			}
			after = {
				
			}
			afterView = {
				
			}
		}
	}
}