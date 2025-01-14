extends Node

var actset
var activeunit
var teams

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var actfile = FileAccess.open("res://pseudo.dmon", FileAccess.READ)
	actset = JSON.parse_string(DmonParser.prepDmonString(actfile.get_path_absolute()))

var chain = []
var spentPoints = 0
var avaPoints = 10

var commandDict = { #metadata for every command
	"wait" : ["Wait", "wait", 0, "Rolls half of the spent points over into the next turn.", 1, "00"],
	"attack" : ["Attack", "action", 0, "Attacks the provided target.", 3, "05", ["Attack which unit? (Type 'help' for a list of enemies.)"]],
	#"friendly" : ["action", "Attacks the provided target.", 3, "06", ["Attack which unit? (Type 'help' for a list of units.)"]],
	"heal" : ["Heal", "action", "heart", "Heals a small amount of damage from the provided unit.", 3, "03", ["Which party member do you want to heal? (Type 'help' for a list of party members.)"]],
	"bless" : ["Bless", "wait", "holy", "Heals an amount of damage from the party based on the number of points spent.", 4, "00"],
	"use" : ["Use", "vari", 0, "Uses an item from your inventory. Cost dependent on item used.", 2, "09", ["Which item do you want to use?"]],
	"equip" : ["Equip", "vari", 0, "Equips a weapon from your inventory. Cost dependent on weapon equipped.", 2, "11", ["Which weapon do you want to equip?"]],
	"exec" : ["sys"],
	"skip" : ["sys"]
}

var actTypeColors = {
	"wait" : Color(0.48,0.41,0.93,0.7),
	"action" : Color(0.44,0.5,0.56,0.7),
	"vari" : Color(0.86,0.44,0.58,0.7),
	"power" : Color(0.78,0.08,0.52,0.7),
	"holy" : Color(1,0.98,0.8,0.7),
	"heart" : Color(0.24,0.7,0.44,0.7)
}
