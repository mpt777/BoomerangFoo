extends Resource
class_name PossibleStages

@export var stages : Array[StageData]


func validate() -> void:
	for stage in self.stages:
		assert(stage.stage.get_class() == "Stage")
