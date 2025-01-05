extends ScrollContainer


@onready var emptylabel = get_node("ChainScrollBox/ChainScrollEmpty")
@onready var pointlabel = get_node("ChainScrollBox/ChainScrollPoints")
@onready var scrollbox = get_node("ChainScrollBox")
@onready var holder = get_node("ChainScrollBox/ChainMargin/ChainHolder")
@onready var pointbar = get_node("../PointBar")
var pointText = "Points: %s "
var susPoints
#var chainButtonStyle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var relanode = get_node("../ChainActScroll")
	self.position.x = relanode.position.x + (relanode.size.x * 1.05)
	self.position.y = relanode.position.y + (relanode.size.y * 0.075)
	self.size.x = relanode.size.x
	self.size.y = relanode.size.y * 0.4
	self.visible = false
	#var chainButtonStyle = StyleBoxFlat.new()
	#chainButtonStyle.content_margin_left = 30
	get_node("ChainScrollBox/ChainMargin").add_theme_constant_override("margin_top",pointlabel.size.y)
	pointbar.size = Vector2(self.size.x,self.size.y*0.15)
	pointbar.position = Vector2(self.position.x,self.position.y - pointbar.size.y)
	pointbar.max_value = Balls.avaPoints

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pointbar.visible = self.visible

func _on_add_chain(selection):
	if Balls.spentPoints + Balls.commandDict[selection][4] <= Balls.avaPoints:
		holder.add_item_to_chain(selection)
	else:
		print("Not enough points!")

func update_points():
	pointbar.value = Balls.spentPoints
	pointlabel.text = pointText % Balls.spentPoints
	if len(Balls.chain) != 0:
		emptylabel.visible = false
		pointlabel.visible = true
	else:
		emptylabel.visible = true
		pointlabel.visible = false
	for item in get_node("../ChainActScroll/ChainActBox").get_children():
		if Balls.commandDict[item.name][4] > Balls.avaPoints - Balls.spentPoints:
			item.disabled = true
		else:
			item.disabled = false
