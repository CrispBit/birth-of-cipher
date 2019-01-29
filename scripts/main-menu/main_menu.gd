extends Node

export var file_selection_scene_path = "";

func _input(event):
    if event.is_pressed():
        get_tree().change_scene(file_selection_scene_path)