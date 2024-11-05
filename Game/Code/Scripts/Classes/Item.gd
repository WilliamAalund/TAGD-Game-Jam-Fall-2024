extends Node

class_name Item

var nameItem
var priceItem
var descriptionItem
var modifierItem
var lvlreqItem
var typeItem

func _init(item_name, item_price, item_description, item_modifier, item_lvlreq, item_type):
	pass
	self.nameItem = item_name
	self.priceItem = item_price
	self.descriptionItem = item_description
	self.modifierItem = item_modifier
	self.lvlreqItem = item_lvlreq
	self.typeItem = item_type


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	print("item class instantiated")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
