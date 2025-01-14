extends Node


@onready var textbox = get_node("../HUD/TestPrintLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textbox.modulate.a = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_enter_combat():
	pass
	#TODO make this cache the current active player/enemy parties and relevant info (skill bank, etc)
	#when combat starts for the first time

func print_label(printtext, delay=0.7):
	textbox.text = printtext
	textbox.visible_ratio = 0
	textbox.visible = true
	if textbox.modulate.a != 1:
		textbox.modulate.a = 0
	var tween = create_tween()
	await tween.tween_property(textbox,"modulate:a",1,0.5).finished
	tween.stop()
	tween = create_tween()
	await tween.tween_property(textbox,"visible_ratio",1,.1*textbox.text.length()).finished
	await get_tree().create_timer(delay).timeout

func _on_execute_chain():
	for fullset in Balls.chain: #full list of actions
		var icomm = Balls.actset[fullset[0]] #array containing the component commands of each action
		for oneset in icomm: #each component command of a given action
			match oneset[0]:
				"ASSIGN":
					print("Recognized ASSIGN command")
					#print(oneset[1][0][1])
					print(get_node("../Five").get(oneset[1][0][1].to_lower()))
				"PRINT":
					print("Recognized PRINT command")
					await print_label(oneset[1][0][0])
				"ATTACK":
					print("Recognized ATTACK command")
					print(oneset[1][-1])
					for item in oneset[1][-1]:
						await print_label(item)
				"HEAL":
					print("Recognized HEAL command")
				"CALL":
					print("Recognized CALL command")
				_:
					print("Unrecognized command type ",oneset[0])
	create_tween().tween_property(textbox,"modulate:a",0,0.3)

#TODO replace the print functions in the switch statement with proper functions somewhere else in the class
#argument handler can come later just get some basic placeholder behavior in place to test
#holy shit why did i structure dmonscript exports like this these lists are nested so deep the light of god cannot reach them
