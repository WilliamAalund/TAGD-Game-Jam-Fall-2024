extends Node

class_name Item

var nameItem
var weapIDItem
var descriptionItem
var lvlreqItem
var typeItem

func _init(item_name, item_weapID, item_description, item_lvlreq, item_type):
	pass
	self.nameItem = item_name
	self.weapIDItem = item_weapID
	self.descriptionItem = item_description
	self.lvlreqItem = item_lvlreq
	self.typeItem = item_type


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
