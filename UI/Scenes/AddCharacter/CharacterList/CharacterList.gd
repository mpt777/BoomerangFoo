extends HBoxContainer
class_name CharacterList

var CHARACTER_CIRCLE := preload("res://UI/Scenes/AddCharacter/CharacterCircle/CharacterCircle.tscn")

@export var avatar_select : AvatarSelect
var character_circles : Array[CharacterCircle] 
var show_cosmetics : bool = true

func _ready():
	$"/root/Signals".connect("avatar_selected", select_avatar)
	$"/root/Signals".connect("controllers_changed", modify_player)
	
	$"/root/Signals".connect("add_bot", add_bot)
	$"/root/Signals".connect("remove_bot", remove_bot)
	
	#$"/root/Signals".connect("process_add_character_state", process_add_character_state)
	
func initialize_players():
	for index in Game.controllers:
		add_player(Game.controllers[index])

func modify_player(controller : Controller, connected : bool) -> void:
	if connected:
		add_player(controller)
	else:
		remove_player(controller)
	
func add_player(controller: Controller) -> void:
	var player_data = PlayerData.new()
	player_data.controller = controller
	add_character(player_data)
	
	if player_data.controller.is_joypad:
		var avatar_select_circle : AvatarSelectCircle = avatar_select.random_avatar()
		avatar_select_circle.button.emit_signal("ControllerAdded", player_data.controller)
	
func remove_player(controller: Controller) -> void:
	for child in get_children():
		if child.character_data.controller == controller:
			Utils.remove_item(self.character_circles, child)
			Game.remove_character(child.character_data)
			child.queue_free()
			return
	
func add_character(character_data : CharacterData) -> void:
	var character_circle = CHARACTER_CIRCLE.instantiate() as CharacterCircle
	character_circle.constructor(character_data)
	add_child(character_circle)
	self.character_circles.append(character_circle)
	character_circle.set_cosmetic_visibility(self.show_cosmetics)
	Game.add_character(character_data)
	
func set_cosmetic_visibility(m_visible):
	self.show_cosmetics = m_visible
	for child in self.character_circles:
		child.set_cosmetic_visibility(self.show_cosmetics)
	
func remove_character(character_data : CharacterData):
	for child in get_children():
		child = child as CharacterCircle
		if child.character_data == character_data:
			child.queue_free()
			Game.remove_character(character_data)
			
func find_character_circle(controller: Controller) -> CharacterCircle:
	var player_character_circles = self.get_children().filter(func (x): return x.character_data is PlayerData)
	var character_circles = player_character_circles.filter(func (x): return x.character_data.controller == controller)
	return character_circles[0]

func select_avatar(controller: Controller, avatar_data: AvatarData) -> void:
	var character_circle = find_character_circle(controller) 
	character_circle.set_avatar(avatar_data)
	
### Bot Code ###################################################################

func add_bot() -> void:
	var enemy_data = EnemyData.new()
	add_character(enemy_data)
	
func remove_bot() -> void:
	var last_child_data = get_child(get_child_count() - 1) as CharacterCircle
	if last_child_data.character_data is EnemyData:
		remove_character(last_child_data.character_data)
