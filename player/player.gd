extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_is_alive = true

var attack_is_in_progress = false

const SPEED = 100
var current_direction = "none"

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta: float) -> void:
	player_movement()
	enemy_attack()
	
	if health <= 0:
		player_is_alive = false #go back to menu or respond
		health = 0
		print("player has been killed")
		self.queue_free()

func player_movement() -> void:
	velocity = Vector2(0,0)
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
			if attack_is_in_progress == false:
				animation.play("back_walk" if is_moving else "back_idle")
		"down":
			animation.flip_h = true
			if attack_is_in_progress == false:
				animation.play("front_walk" if is_moving else "front_idle")
		"right":
			animation.flip_h = false
			if attack_is_in_progress == false:
				animation.play("side_walk" if is_moving else "side_idle")
		"left":
			animation.flip_h = true
			if attack_is_in_progress == false:
				animation.play("side_walk" if is_moving else "side_idle")

func player():
	pass

func _on_player_hit_box_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = true

func _on_player_hit_box_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$AttackCoolDown.start()
		print(health)

func _on_attack_cool_down_timeout() -> void:
	enemy_attack_cooldown = true
	
func attack():
	var direction = current_direction
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_is_in_progress = true
		if direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			
			
	
