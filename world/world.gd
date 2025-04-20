extends Node2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	change_scene()

func _on_cliffside_transistion_point_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = true


func _on_cliffside_transistion_point_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		Global.transition_scene = false
		
func change_scene():
		if Global.transition_scene == true:
			if Global.current_scene == "world":
				get_tree().change_scene_to_file("res://cliff_side/cliff_side.tscn")
				Global.finish_changescenes()
