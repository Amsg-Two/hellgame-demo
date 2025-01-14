@icon("res://ph_pixels/class_icons/unit.png")
class_name Unit extends Node2D

#region Exports
@export_category("Unit Stats")
@export var unitName: String
@export var hp = 10 #unit current hp. gets cached at combat start as maxhp below
@export var atk = 5 #unit attacking stat. subject to change
@export var def = 5 #unit defending stat. also subject to change
@export var agi = 5 #unit agility/speed stat. i think all of these are subject to change
@export var lck = 5 #unit luck stat. ditto
@export var flo = 5 #unit flow (magic/other) stat. this one is pretty set actually
#endregion

#region Not exports, but stats
var points #the unit's available points. updated per-turn
var roll = 0 #the unit's rolled-over points, e.g. via the Wait action. reset every turn unless specified otherwise
var overheal = [0,0] #the unit's overheal information; the first slot indicates the overheal they started with, second indicates their current overheal
var status = [] #a list containing all statuses currently applied to the unit
var inv = [] #a list containing data for all items in the unit's inventory
var equip = null #a pointer to the object that corresponds to the unit's equipped weapon. null (unarmed) by default
#endregion
