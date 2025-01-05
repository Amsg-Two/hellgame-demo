extends Node


var actlink

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self.connect("pressed", _on_clicked)
	actlink = Balls.commandDict[self.name]
	self.pressed.connect($/root/Main/HUD/ChainScroll._on_add_chain.bind(self.name))
	self.text = Balls.commandDict[self.name][0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_clicked():
	#print("Click registered for " + self.text)

func _make_custom_tooltip(for_text:String) -> Control:
	var tooltip = preload("res://tt_label.tscn").instantiate()
	tooltip.push_paragraph(HORIZONTAL_ALIGNMENT_CENTER)
	tooltip.push_bold()
	tooltip.append_text(actlink[0])
	tooltip.pop_all()
	tooltip.push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
	tooltip.push_italics()
	tooltip.append_text("Points: ")
	if actlink[1] == "wait":
		tooltip.append_text("Ends turn (minimum of " + str(actlink[4]) + ")")
	elif actlink[1] == "vari":
		tooltip.append_text("Variable")
	else:
		tooltip.append_text(str(actlink[4]))
	tooltip.pop_all()
	tooltip.push_paragraph(HORIZONTAL_ALIGNMENT_LEFT)
	tooltip.append_text(actlink[3])
	if actlink[4] > Balls.avaPoints - Balls.spentPoints:
		tooltip.push_color("orange red")
		tooltip.push_italics()
		tooltip.append_text("\nNot enough points to add!")
	tooltip.clip_contents = false
	tooltip.autowrap_mode = 0
	#var bgc = StyleBoxFlat.new()
	#if actlink[2] is not int:
		#bgc.bg_color = Balls.actTypeColors[actlink[2]]
	#else:
		#bgc.bg_color = Balls.actTypeColors[actlink[1]]
	#tooltip.add_theme_stylebox_override("normal",bgc)
	return tooltip
