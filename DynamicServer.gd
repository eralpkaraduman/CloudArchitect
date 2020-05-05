extends "res://Server.gd"

export var db: String


func _init():
	type = "Database"

func _on_DatabaseConfig_text_changed():
	db = $ConfigWindow/Database/DatabaseConfig.text

#move this to Server and then override it
func process_request(req):
	if req.response:
		req.route.pop_back()
	else:
		req.route.append(db)
		
	yield(calculate_response_time(), "completed")
	
	req.send(100)

	var response =	yield(req, 'processed')

		
	return response
	
