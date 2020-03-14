extends Node

var _store = {}

func _ready():
	pass

func put(key, value):
	_store[key] = value

func get(key):
	return _store[key]

func has(key) -> bool:
	return _store.has(key)
