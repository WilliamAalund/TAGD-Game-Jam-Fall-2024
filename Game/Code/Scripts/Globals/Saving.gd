extends Node

# Path to the file where data will be saved and loaded from
var save_file_path : String = "res://save.json"

var fresh_save_file = {
	"farthest_level" = -1,
	"high_score" = -1,
	"high_score_name" = ""
}


# Save the data to a file
func save_data(data: Dictionary) -> void:
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	if file:
		# Create an instance of the JSON class to convert the dictionary to JSON string
		var json = JSON.new()
		var json_string = json.stringify(data)
		file.store_string(json_string)
		file.close()
		print("Data saved successfully!")
	else:
		print("Error saving data!")

# Load the data from the file
func load_data() -> Dictionary:
	var data = fresh_save_file  # Start with default data
	var file = FileAccess.open(save_file_path, FileAccess.READ)
	if file:
		var json_string = file.get_as_text()
		file.close()
		var json = JSON.new()
		var result = json.parse(json_string)
		if result == OK:
			data = json.data  # Parsed data
			print("Data loaded successfully!")
		else:
			print("Error parsing data from JSON: ", result)
	else:
		print("File not found, loading default data.")
	return data

# Example API functions to work with the data
func set_player_data(player_name: String, player_score: int) -> void: # FIXME: Not a very useful function. 
	var player_data = {
		"name": player_name,
		"score": player_score
	}
	save_data(player_data)

func set_farthest_level(level_reached: int) -> bool:
	var current_save_data = load_data()
	if level_reached > current_save_data["farthest_level"]:
		current_save_data["farthest_level"] = level_reached
		save_data(current_save_data)
		print("Saving: Farthest level increased to: ", level_reached)
		return true
	else:
		return false

func reset_save_data():
	var file = FileAccess.open(save_file_path, FileAccess.WRITE)
	if file:
		# Create an instance of the JSON class to convert the dictionary to JSON string
		var json = JSON.new()
		var json_string = json.stringify(fresh_save_file)
		file.store_string(json_string)
		file.close()
		print("Data reset successfully!")
	else:
		print("Error saving data!")

func get_farthest_level_reached() -> int:
	var current_save_data = load_data()
	return current_save_data["farthest_level"]


func get_player_data() -> Dictionary:
	return load_data()
