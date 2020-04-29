extends "res://Server.gd"

signal backend_config_changed

export var backend_config = []

func vars():
	$CollisionShape2D/AnimatedSprite.animation = "LoadBalancer"

func _init():
	vars()

func _on_BackendConfig_text_changed():
	backend_config = $ConfigWindow/Servers/BackendConfig.text.split('\n')
	emit_signal("backend_config_changed")
	
func request(original_req):

	var server = backend_config[randi() % backend_config.size()]
	var level = get_parent()
	
	var req = Request.instance()
	req.init(original_req,level.nav_map, level.objects[server], 1000)

	level.add_child(req)
	req.set_process(true)
	
	return req
