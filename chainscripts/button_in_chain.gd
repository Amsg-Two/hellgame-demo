extends Button

var styleIncomplete
var styleComplete
var actlink
var subcodes = []
signal removal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	styleIncomplete = StyleBoxFlat.new()
	styleIncomplete.bg_color = Color("red")
	styleComplete = StyleBoxFlat.new()
	styleComplete.bg_color = Color("dark_green")
	self.pressed.connect(self._on_pressed)
	#self.add_theme_stylebox_override("focus",StyleBoxEmpty.new())
	actlink = Balls.commandDict[self.get_meta("command")]
	self.removal.connect(get_node("..")._on_update_selfchain)
	parse_actlink(actlink)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if self.get_meta("complete") == true:
		self.add_theme_stylebox_override("normal",styleComplete)
	else:
		self.add_theme_stylebox_override("normal",styleIncomplete)

func _on_pressed():
	if len(Balls.chain) == 1:
		Balls.spentPoints = 0
		Balls.chain.clear()
	else:
		Balls.spentPoints -= Balls.chain[self.get_meta("chaindex")][1]
		Balls.chain.remove_at(self.get_meta("chaindex"))
	for item in get_node("..").get_children():
		if item.get_meta("chaindex") > self.get_meta("chaindex"):
			item.set_meta("chaindex", item.get_meta("chaindex") - 1)
	removal.emit()
	self.queue_free()

func parse_actlink(actor):
	var fullcodearr = []
	for item in actor[5]:
		fullcodearr.append(item)
	for val in range(0,len(fullcodearr),2):
		subcodes.append(fullcodearr[val] + fullcodearr[val+1])
	if subcodes == ["00"]:
		self.set_meta("complete", true)
	return subcodes
