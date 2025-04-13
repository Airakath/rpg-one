extends CharacterBody2D

const SPEED = 100
var current_direction = "none"

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta: float) -> void:
	player_movement()

func player_movement() -> void:
	velocity = Vector2.ZERO
	var input_vector = Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * SPEED

		if input_vector.y < 0:
			current_direction = "up"
		elif input_vector.y > 0:
			current_direction = "down"
		elif input_vector.x > 0:
			current_direction = "right"
		elif input_vector.x < 0:
			current_direction = "left"

		play_animation(1)
	else:
		play_animation(0)

	move_and_slide()

func play_animation(movement):
	var animation = $AnimatedSprite2D
	var is_moving = movement == 1

	match current_direction:
		"up":
			animation.flip_h = true
			animation.play("back_walk" if is_moving else "back_idle")
		"down":
			animation.flip_h = true
			animation.play("front_walk" if is_moving else "front_idle")
		"right":
			animation.flip_h = false
			animation.play("side_walk" if is_moving else "side_idle")
		"left":
			animation.flip_h = true
			animation.play("side_walk" if is_moving else "side_idle")
