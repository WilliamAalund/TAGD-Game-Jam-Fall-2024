extends Button


@onready var name_label = $VBoxContainer/ItemName
@onready var price_label = $VBoxContainer/ItemPrice
@onready var description_label = $VBoxContainer/ItemDescription


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_button_elements(weapon_name, price, description, type, image):
	name_label.text = weapon_name
	price_label.text = "Cost: " + str(price) + " scrap"
	description_label.text = description
	var picture = load(image)
	$VBoxContainer/ItemImage.texture = picture
	
