extends Node

export(NodePath) var emitter_path;
onready var file_id;

func _ready():
    var emitter_node = get_node(emitter_path);
    emitter_node.connect("submit", self, "_submit");
    emitter_node.connect("cancel", self, "_cancel");

func _submit(name):
    var dir = Directory.new();
    if (!dir.dir_exists("user://save")):
        dir.make_dir_recursive("user://save");
    var new_file = File.new();
    new_file.open("user://save/file" + str(file_id + 1) + ".sav", File.WRITE);
    new_file.store_16(0); # region number
    new_file.store_16(0); # area number
    new_file.store_8(file_id);
    new_file.store_pascal_string(name);
    new_file.close();
    get_tree().change_scene(Statics.file_selection_scene_path);

func _cancel():
    get_tree().change_scene(Statics.file_selection_scene_path);