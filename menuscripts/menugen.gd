extends Node

signal attach_me

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	attach_me.connect($/root/Main/HUD/MenuButtonHandler._on_connect_attach)
	attach_me.emit(self.get_path())

#func _on_attach_menu() -> void:
#	pass # Replace with function body.
