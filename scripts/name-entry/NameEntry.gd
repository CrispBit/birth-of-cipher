extends Node

export(NodePath) var emitter_path;

func _ready():
    var emitter_node = get_node(emitter_path);
    emitter_node.connect("submit", self, "_submit");
    emitter_node.connect("cancel", self, "_cancel");

func _submit(name):
    print(name);
    get_tree().change_scene(Statics.file_selection_scene_path);

func _cancel():
    get_tree().change_scene(Statics.file_selection_scene_path);