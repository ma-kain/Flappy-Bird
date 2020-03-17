#node_accessor.gd (auto-load script)
extends Node

func _ready():
	print("node_accessor_ready")

func current_scene():
	return get_tree().current_scene 

func bird(): 
	return current_scene().get_node("bird")

func camera(): 
	return current_scene().get_node("camera")

func pipe_spawner(): 
	return current_scene().get_node("pipe_spawner")

func is_game_stage() -> bool:
	return get_tree().current_scene.name == 'game_world'

func is_menu_stage() -> bool:
	return get_tree().current_scene.name == 'main_menu'
