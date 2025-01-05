extends VBoxContainer


@onready var scroller = get_node("/root/Main/HUD/ChainScroll")
var runningIndex

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_item_to_chain(selection):
	var actArray = []
	var actPoints
	runningIndex = len(Balls.chain)
	if Balls.commandDict[selection][1] != "wait":
		actPoints = Balls.commandDict[selection][4]
	else:
		actPoints = Balls.avaPoints - Balls.spentPoints
	actArray.append(selection)
	actArray.append(actPoints)
	#Balls.chain.append(selection)
	Balls.spentPoints += actPoints
	var addact = Button.new()
	addact.text = Balls.commandDict[selection][0]
	addact.alignment = HORIZONTAL_ALIGNMENT_CENTER
	#addact.grow_vertical = Control.GROW_DIRECTION_BOTH
	addact.size_flags_horizontal = Control.SIZE_FILL
	addact.set_script(load("res://chainscripts/button_in_chain.gd"))
	addact.set_meta("complete", false)
	addact.set_meta("command", selection)
	addact.set_meta("chaindex", runningIndex)
	addact.set_meta("selfpoints", actArray[1])
	if Balls.commandDict[selection][1] == "wait":
		addact.size_flags_vertical = Control.SIZE_EXPAND_FILL
	var arglen = len(addact.parse_actlink(Balls.commandDict[actArray[0]]))
	var argarr = []
	for x in range(arglen):
		argarr.append("")
	actArray.append(argarr)
	Balls.chain.append(actArray)
	#addact.add_theme_stylebox_override("normal",chainButtonStyle)
	scroller.update_points()
	self.add_child(addact)
	addact.size_flags_stretch_ratio = actArray[1] / Balls.avaPoints

func rebuild_item_in_chain(itemarr):
	var selection = itemarr[0]
	var addact = Button.new()
	addact.text = Balls.commandDict[selection][0]
	addact.alignment = HORIZONTAL_ALIGNMENT_CENTER
	#addact.grow_vertical = Control.GROW_DIRECTION_BOTH
	addact.size_flags_horizontal = Control.SIZE_FILL
	#addact.size_flags_vertical = Control.SIZE_EXPAND_FILL
	addact.set_script(load("res://chainscripts/button_in_chain.gd"))
	addact.set_meta("complete", false)
	addact.set_meta("command", selection)
	addact.set_meta("chaindex", runningIndex)
	addact.set_meta("selfpoints", itemarr[1])
	if Balls.commandDict[selection][1] == "wait":
		addact.size_flags_vertical = Control.SIZE_EXPAND_FILL
	addact.size_flags_stretch_ratio = itemarr[1] / Balls.avaPoints
	if Balls.commandDict[selection][1] != "wait":
		Balls.spentPoints -= itemarr[1]
	self.add_child(addact)
	return addact

func _on_update_selfchain():
	var susPoints = 0
	for item in self.get_children():
		self.remove_child(item)
		item.queue_free()
	runningIndex = 0
	for item in Balls.chain:
		var curItem = rebuild_item_in_chain(item)
		if Balls.commandDict[item[0]][1] == "wait":
			susPoints += Balls.avaPoints - susPoints
		else:
			susPoints += curItem.get_meta("selfpoints")
		runningIndex += 1
	Balls.spentPoints = susPoints
	#var spaceres = Control.new()
	#spaceres.size_flags_stretch_ratio = Balls.avaPoints - Balls.spentPoints
	#self.add_child(spaceres)
	#spaceres.set_meta("command", "holder")
	scroller.call("update_points")
