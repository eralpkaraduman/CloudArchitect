extends KinematicBody2D


var Request = preload("res://Request.tscn")

var can_grab = false
var grabbed_offset = Vector2()
export var dns_name = ""
export var dns_prefix = "server_"

func init(level, servers, all):
	var margin = all.size()*10
	position = Vector2(500+margin, 500+margin)
	var id = servers.size()
	dns_name = dns_prefix + str(id)
	
	servers.append(self)
	all[dns_name] = self
	
	level.add_child(self)

func _ready():
	$ConfigWindow.visible = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		can_grab = event.pressed
		grabbed_offset = position - get_global_mouse_position()

func _process(delta):
	$DNSNameLabel.text = dns_name
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and can_grab:
		position = get_global_mouse_position() + grabbed_offset

func get_response(req):
	request(req)
	return_response(req)

func return_response(req):
	var level = get_parent()
	req.pathfind(level.nav_map, req.origin)

func request(req):
	print('backend_request')
	
func _on_ToggleConfig_pressed():
	if $ConfigWindow.visible:
		$ConfigWindow.visible = false
		$ToggleConfig.text = "Configure"
	else:
		$ConfigWindow.visible = true
		$ToggleConfig.text = "Hide config"
