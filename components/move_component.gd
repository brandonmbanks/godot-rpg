class_name MoveComponent
extends Node

@export var actor: Node2D
@export var input_vector: Vector2

const MAX_SPEED: int = 100
const ACCEL: int = 10
const FRICTION: int = 10

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCEL * delta
		velocity = velocity.limit_length(MAX_SPEED * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	actor.translate(velocity)
