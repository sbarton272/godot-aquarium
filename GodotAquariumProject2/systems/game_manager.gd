extends Node

class_name GameManager

signal shop_opened()

@export var tank: Tank

func _ready():
	pass

func _input(event: InputEvent):
	if event.is_action_released("OpenShop"):
		emit_signal("shop_opened")
		get_tree().paused = true
	if event.is_action_released("ui_cancel"):
		get_tree().paused = false
