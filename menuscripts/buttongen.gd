extends Node

signal update_menu
signal connect_me
signal attach_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = true
	connect_me.connect($/root/Main/HUD/MenuButtonHandler._on_connect_init)
	connect_me.emit(self.get_path())
	attach_menu.emit()
	self.connect("pressed",_on_clicked)
	update_menu.connect($/root/Main/HUD/MenuButtonHandler._on_update_menu)

func _on_clicked():
	update_menu.emit(self.get_path())
	if Balls.chain.size() > 0:
		print(Balls.chain[0])
