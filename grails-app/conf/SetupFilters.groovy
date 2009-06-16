import com.synergyj.grain.auth.*

class SetupFilters {
	def filters = {
		all(controller:'*', action:'*') {
			before = {
				if(User.count() == 0) {
					log.info "There is no users in Grain"
					if(controllerName!="setup") {
						log.trace "redirecting to setup controller"
						redirect controller:'setup', action:'index'
					}					
				}
			}
			after = {
				
			}
			afterView = {
				
			}
		}
	}
}