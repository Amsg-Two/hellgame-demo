extends Button

@onready var actscroller = get_node("../ChainActScroll")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.x = actscroller.position.x
	self.size = Vector2(actscroller.size.x * 0.8, self.size.y * 1.8)
	self.pressed.connect(_on_pressed)
	call_deferred("_on_update_actscroll_size")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.visible = actscroller.visible

func _on_update_actscroll_size() -> void:
	var csize = 0
	for item in actscroller.get_children():
		csize += item.size.y
	if csize < actscroller.size.y:
		self.position.y = actscroller.position.y + csize + 10
	else:
		self.position.y = actscroller.position.y + actscroller.size.y + 10

func _on_pressed():
	for item in Balls.chain:
		for instruct in Balls.actset[item[0]]:
			pass
