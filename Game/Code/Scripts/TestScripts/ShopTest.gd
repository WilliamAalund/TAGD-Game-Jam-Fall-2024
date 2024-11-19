extends Node

signal player_continue

# Load the dictionary script
var item_data = preload("res://Code/Scripts/TestScripts/ItemDict.gd").new()

var target_types = ["Weapon", "Boost", "Health"]  # Adjust as needed


# Function to select random items ensuring they are from different types
var selected_items = []

@export var shop_level = 1

# Function to select random items ensuring each button displays a specific type
func select_random_items():
	selected_items.clear()
	
	# For each target type, select a random item of that type
	for target_type in target_types:
		var items_of_type = []
		
		# Collect all items that match the current target type
		for item_name in item_data.Items.keys():
			var item = item_data.Items[item_name]
			if item.type == target_type and item.reqlvl <= shop_level:
				items_of_type.append(item_name)
		
		# Select a random item from the items of this type (if any exist)
		if items_of_type.size() > 0:
			var random_item_name = items_of_type[randi() % items_of_type.size()]
			selected_items.append(random_item_name)
		else:
			selected_items.append(null)


func update_ui():
	
	update_ui_box(get_node("ItemButton1"), selected_items[0]) #Weapon
	update_ui_box(get_node("ItemButton2"), selected_items[1]) #Boost
	update_ui_box(get_node("ItemButton3"), selected_items[2]) #Health


func update_ui_box(ui_box, item_name):
	if item_name == null:
		# If no item is available, display "No Item Available"
		ui_box.update_button_elements("null", 999, "item.description", "")
		#ui_box.get_node("ItemName").text = "No Item Available"
		#ui_box.get_node("ItemPrice").text = ""
		#ui_box.get_node("ItemDescription").text = "No items meet the level requirement."
		#ui_box.get_node("ItemType").text = ""
	else:
		# Display the selected item's details
		var item = item_data.Items[item_name]
		ui_box.update_button_elements(item_name, 999, item.description, item.type)
		#ui_box.get_node("ItemName").text = item_name
		#ui_box.get_node("ItemPrice").text = "Price: $"
		#ui_box.get_node("ItemDescription").text = item.description
		#ui_box.get_node("ItemType").text = "Type: " + item.type
# Randomize on ready
func _ready():
	randomize()
	select_random_items()
	update_ui()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_item_button_pressed() -> void:
	pass # Replace with function body.


func _on_continue_button_pressed() -> void:
	pass 
	print("go to game")
	player_continue.emit()
