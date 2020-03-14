#utils.gd (auto-load script)
extends Node

func _ready():
	print("node_accessor_ready")

func game_root(): 
	return get_tree().root

func game_world(): 
	return game_root().get_node("game_world")

func bird(): 
	return game_world().get_node("bird")

func camera(): 
	return game_world().get_node("camera")

func pipe_spawner(): 
	return game_world().get_node("pipe_spawner")
