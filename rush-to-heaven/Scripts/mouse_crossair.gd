extends Control

@export var radius: float = 20.0
@export var line_width: float = 2.0
@export var color: Color = Color(1.0, 0.2, 0.2)


func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	if not owner.is_multiplayer_authority():
		queue_free()
		return

func _process(_delta: float) -> void:
	# Prottek frame-e mouse-er position update kore circle redraw kora
	queue_redraw() 

func _draw() -> void:
	# Mouse-er global position graphical reticle hisebe use hobe
	var mouse_pos := get_viewport().get_mouse_position()
	draw_arc(mouse_pos, radius, 0.0, TAU, 48, color, line_width, true)
	
func get_mouse_crossair_position()->Vector2:
	return get_viewport().get_mouse_position()
