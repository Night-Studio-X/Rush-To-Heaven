extends ProgressBar

@export var health_node: Node

func _ready() -> void:
	if not is_multiplayer_authority():
		visible = false
	max_value = health_node.max_health

func _process(_delta: float) -> void:
	value = health_node.health
	
