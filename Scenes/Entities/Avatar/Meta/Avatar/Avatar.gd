extends Node3D
class_name Avatar

@onready var n_camera_fix : Node3D = $Animation/CameraFix
@onready var n_animation : Node3D = $Animation
@onready var state_machine = $AnimationTree.get("parameters/playback")

@onready var n_blend_tree = $BlendTree

@onready var n_right_hand = $Animation/CameraFix/Right
@onready var n_right_hand_remote = $Animation/CameraFix/Right/RemoteTransform3D

@export var default_cosmetics : Array[CosmeticData]
@export var anchors : Array[Anchor]
var anchor_register := AnchorRegister.new()

func _ready():
	self.name = "Avatar"
	for anchor in self.anchors:
		self.anchor_register.register(anchor)
	self.add_cosmetics(self.default_cosmetics)
	#n_blend_tree.active = true
	
func travel(state : String) -> void:
	state_machine.travel(state)
	
func walk_idle(value : float) -> void:
	create_tween().tween_method(
		func(v: float) -> void: n_blend_tree.set("parameters/WalkIdle/blend_amount", v),
		n_blend_tree.get("parameters/WalkIdle/blend_amount"),
		value, 0.3
	)
	
func cast(travel : String) -> void:
	n_blend_tree.get("parameters/Cast/playback").travel(travel)
	
	
func add_cosmetics(cosmetics : Array[CosmeticData]):
	for cosmetic in cosmetics:
		self.change_cosmetic(cosmetic)
		
func change_cosmetic(cosmetic : CosmeticData):
	self.remove_cosmetic(cosmetic.alias)
	var anchor := anchor_register.anchor(cosmetic.alias)
	var c = cosmetic.instance_scene()
	add_child(c)
	anchor.add(c)
	
func remove_cosmetic(alias: Enums.AnchorAlias):
	var anchor := anchor_register.anchor(alias)
	if not anchor:
		return
	anchor.destroy_nodes()
		
	#for cosmetic in self.data.avatar.default_cosmetics:
		#var anchor = anchor_register.anchor(cosmetic.alias)
		#if not anchor:
			#continue
		#if anchor.nodes:
			#continue
		#_ac.call(cosmetic)
