export var ip: String
const max_ip_block = 256


func _init():
	ip = "192.168."+ str(randi()%max_ip_block) + "." + str(randi()%max_ip_block)

