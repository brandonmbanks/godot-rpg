extends Node2D

@onready var move_component: Node = $MoveComponent as MoveComponent

func _input(event: InputEvent) -> void:
	var input_vector: Vector2 = Vector2.ZERO
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")

	move_component.input_vector = input_vector
