extends Node

signal changed_health(new_health:int)
signal died

@export var max_health: int = 1000
@export var health: int

func _ready() -> void:
	health = max_health
	
func _physics_process(_delta: float) -> void:
	if not multiplayer.is_server() and Input.is_action_just_pressed("fire"):
		print("client sees car ", get_parent().name, " health: ", health)
	
func take_damage(amount)->void:
	if not multiplayer.is_server():
		return 
	health = maxi(health - amount, 0)
	if health <= 0:
		died.emit()
		print('car ',get_parent().name, ' has died.')
	changed_health.emit(health)
	print('car ',get_parent().name, ' health ', health)
