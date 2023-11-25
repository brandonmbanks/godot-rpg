extends CharacterBody2D

const MAX_SPEED: int = 80
const ACCEL: int = 500
const FRICTION: int = 500

enum states {
	MOVE,
	ROLL,
	ATTACK
}

var state = states.MOVE
var input_vector: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

func _ready() -> void:
	animation_tree.active = true

func _process(delta: float) -> void:
	match state:
		states.MOVE:
			move_state(delta)
		states.ATTACK:
			attack_state(delta)
		states.ROLL:
			roll_state(delta)

func move_state(delta: float) -> void:
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		# we dont want the player to change their position while attacking
		# we set the blend position here so the position is set
		animation_tree.set("parameters/Attack/blend_position", input_vector)
		animation_state.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCEL * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	move_and_slide()

	if Input.is_action_just_pressed("attack"):
		state = states.ATTACK

func attack_state(delta: float) -> void:
	animation_state.travel("Attack")
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	move_and_slide()

func roll_state(delta: float) -> void:
	pass

# this is created by clicking the AnimationTree than the Node tab
# double click the animation_finished Signal and connect it to the Player Node
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if "attack_" in anim_name or "roll_" in anim_name:
		state = states.MOVE
