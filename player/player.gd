extends CharacterBody2D

const MAX_SPEED: int = 80
const ACCEL: int = 500
const FRICTION: int = 500

var input_vector: Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")

func _physics_process(delta: float) -> void:
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCEL * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()
