extends Node

var player_current_attack = false

var current_scene = "world"
var transition_scene = false

var player_exit_cliffside_position_x = 365
var player_exit_cliffside_position_y = 14
var player_start_position_x = 102
var player_start_position_y = 137

var game_first_loadin = true

func finish_changescenes():
	transition_scene = false
	if current_scene == "world":
		current_scene = "cliff_side"
	else:
		current_scene = "world"
