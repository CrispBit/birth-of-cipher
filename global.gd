extends Node

func _process(delta):
    if Input.is_action_just_pressed("toggle_fullscreen"):
        OS.window_fullscreen = !OS.window_fullscreen