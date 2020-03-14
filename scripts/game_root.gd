extends Node

var current_score = 0
var best_score = 0

func _ready():
	pass

func _on_game_world_change_scene(scene_path):
	scene_changer.change_scene_to(scene_path)
