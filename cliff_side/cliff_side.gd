extends Node2D


func _process(delta: float) -> void:
	change_scenes()

func _on_cliff_side_exit_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true

func _on_cliff_side_exit_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = false

func change_scenes():
	if Global.transition_scene == true:
		print(Global.current_scene)
		if Global.current_scene == "cliff_side":
			get_tree().change_scene_to_file("res://world/world.tscn")
			Global.finish_changescenes()
