extends Node

@export var playerUnit: PackedScene
@export var enemyUnit: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var playerAdd = playerUnit.instantiate()
	playerAdd.position = Vector2(614,344)
	playerAdd.scale = Vector2(0.517,0.517)
	self.add_child(playerAdd)
	var enemyAdd = enemyUnit.instantiate()
	enemyAdd.position = Vector2(848,206)
	enemyAdd.scale = Vector2(0.517,0.517)
	self.add_child(enemyAdd)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
