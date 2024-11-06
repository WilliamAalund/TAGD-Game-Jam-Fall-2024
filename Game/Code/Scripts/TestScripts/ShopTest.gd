extends Node
# Load the dictionary script
var item_data = preload("res://Code/Scripts/TestScripts/ItemDict.gd").new()




# Function to select random items ensuring they are from different types
var selected_items = []
func select_random_items():
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


func update_ui():
	if selected_items.size() < 3:
		return
		
	update_ui_box(get_node("ItemButton1"), selected_items[0])
	update_ui_box(get_node("ItemButton2"), selected_items[1])
	update_ui_box(get_node("ItemButton3"), selected_items[2])


func update_ui_box(ui_box, item_name):
	var item = item_data.Items[item_name]
	ui_box.get_node("VBoxContainer/ItemName").text = item_name
	ui_box.get_node("VBoxContainer/ItemPrice").text = "Cost: " + str(item.price) + " scrap"
	ui_box.get_node("VBoxContainer/ItemDescription").text = item.description
	ui_box.get_node("VBoxContainer/ItemLevel").text = "Level Required: " + str(item.reqlvl)
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
