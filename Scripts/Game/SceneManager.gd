extends Node
#class_name SceneManager

@export 
var scenes : Dictionary = {
	"game": "res://Scenes/Enviroment/World/World.tscn"
}

# Description: Add a new scene to the scene collection
# Parameter sceneAlias: The alias used for finding the scene in the collection
# Parameter scenePath: The full path to the scene file in the file system
func add_scene(scene_alias : String, scenePath : String) -> void:
	scenes[scene_alias] = scenePath
	 
# Description: Remove an existing scene from the scene collection
# Parameter sceneAlias: The scene alias of the scene to remove from the collection
func remove_scene(scene_alias : String) -> void:
	scenes.erase(scene_alias)
	 
# Description: Switch to the requested scene based on its alias
# Parameter sceneAlias: The scene alias of the scene to switch to
func switch_scene(scene_alias : String) -> void:
	get_tree().call_deferred("change_scene_to_file", scenes[scene_alias])
	#get_tree().change_scene_to_file(scenes[scene_alias])
 
# Description: Restart the current scene
func restart_scene() -> void:
	get_tree().call_deferred("reload_current_scene")
	#get_tree().reload_current_scene()
	 
# Description: Quit the game
func quit_game() -> void:
	get_tree().call_deferred("quit")
	#get_tree().quit()
