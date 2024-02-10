extends Node
#class_name Serializer

func user(file_path: String) -> String:
	return "user://" + file_path

func write_json(file_path : String, data : Dictionary) -> void:
	var json_file = FileAccess.open(file_path, FileAccess.WRITE)
	json_file.store_line(JSON.stringify(data))

func read_json(file_path : String) -> Dictionary:
	if not FileAccess.file_exists(file_path):
		return {}
	var file_data := FileAccess.open(file_path, FileAccess.READ)
	var parsed_data = JSON.parse_string(file_data.get_as_text())
	
	if parsed_data is Dictionary:
		return parsed_data
	return {}
