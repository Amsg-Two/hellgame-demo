extends Node

var current_open_menu

var buttons = ["empty"]
var menus = ["empty"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_open_menu = 0

func _on_connect_init(sender):
	buttons.append(sender)
	print("Attached " + get_node(sender).name + " at identifier " + str(buttons.find(sender)))

func _on_connect_attach(sender):
	menus.append(sender)
	print("Attached " + get_node(sender).name + " at identifier " + str(menus.find(sender)))

func _on_update_menu(sender):
	#print("Received click from ",sender)
	if current_open_menu == buttons.find(sender):
		current_open_menu = 0
		#get_node(menus[buttons.find(sender)]).visible = false
	else:
		current_open_menu = buttons.find(sender)
		#get_node(menus[current_open_menu]).visible = true
	for item in menus.slice(1):
		get_node(item).visible = false
	if current_open_menu != 0:
		get_node(menus[current_open_menu]).visible = true
	get_node("/root/Main/HUD/ChainScroll").visible = get_node("/root/Main/HUD/ChainActScroll").visible
