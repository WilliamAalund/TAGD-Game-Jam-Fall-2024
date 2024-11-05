extends Node

# Load the dictionary script
var item_data = preload("res://Code/Scripts/TestScripts/ItemDict.gd").new()

# Function to select random items ensuring they are from different types
func select_random_items():
	var selected_items = []
	var used_types = []

#CHANGE IF STATEMENT IN WHILE LOOP TO TRY CATCH
	while selected_items.size() < 3:
		var item_names = item_data.Items.keys()
		var random_item_name = item_names[randi() % item_names.size()]
		var random_item = item_data.Items[random_item_name]
		
		#Check if the item type has already been selected
		if random_item.type not in used_types:
			selected_items.append(random_item_name)
			used_types.append(random_item.type)  # Keep track of used types

# Randomize on ready
func _ready():
	randomize()
	print(item_data.Items.keys())
	select_random_items()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_button_pressed() -> void:
	pass # Replace with function body.
