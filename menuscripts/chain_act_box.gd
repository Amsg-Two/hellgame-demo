extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in Balls.commandDict:
		if Balls.commandDict[item][0] != "sys":
			var actadd = Button.new()
			actadd.name = item
			actadd.tooltip_text = "ダミー"
			actadd.set_script(load("res://chainscripts/actionbuttongen.gd"))
			#actadd.set("theme_override_colors/font_disabled_color", Color("orange red"))
			add_child(actadd)
