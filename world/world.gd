extends Node2D

func _ready() -> void:
	if Global.game_first_loadin == true:
		$Player.position.x = Global.player_start_position_x
		$Player.position.y = Global.player_start_position_y
	else:
		$Player.position.x = Global.player_exit_cliffside_position_x
		$Player.position.y = Global.player_exit_cliffside_position_y

func _process(delta: float) -> void:
	change_scenes()

func _on_cliffside_transition_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true

func _on_cliffside_transition_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = false
		
func change_scenes():
	if Global.transition_scene == true:
		if Global.current_scene == "world":
			get_tree().change_scene_to_file("res://cliff_side/cliff_side.tscn")
			Global.game_first_loadin = false
			Global.finish_changescenes()
