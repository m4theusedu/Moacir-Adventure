extends Node2D

@onready var texture = $texture
@onready var area_sig = $area_sig

const lines : Array[String] = [
	"Ola, aventureiri",
	"LLLLLLLLLLLLllllll",
	"skkkkskksksksksksks",
	"kkkkkkkkkkkkkkkkkkk",
]
func _unhand_input(event):
	if area_sig.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogManage.is_message_active:
			texture.hide()
			DialogManage.start_message(global_position, lines)
	else:
		texture.hide()
		if DialogManage.dialog_box != null:
			DialogManage.dialog_box.queue_free()
			DialogManage.is_message_active = false
			   
