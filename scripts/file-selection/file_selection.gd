extends Node

export var file_id = 0;
export(NodePath) var delete_button_path;
export(NodePath) var select_button_path;
export(NodePath) var center_container_path;

var _delete_button;
var _select_button;
var _last_pressed_file_button;
var _center_container;
var _file_buttons = [];

func _ready():
    _delete_button = get_node(delete_button_path);
    _delete_button.connect("pressed", self, "_delete_button_pressed");
    
    _select_button = get_node(select_button_path);
    _select_button.connect("pressed", self, "_select_button_pressed");
    
    _center_container = get_node(center_container_path);
    
    for i in range(3):
        var file_button = ResourceLoader.load(Statics.file_button_path).instance();
        var texture_button = file_button.get_node("TextureButton");
        texture_button.set_id(i);
        texture_button.connect("pressed", self, "_file_button_pressed", [texture_button]);
        _file_buttons.append(texture_button);
        _center_container.add_child(file_button);
    
    _reload_files();

func _reload_files():
    for file_button in _file_buttons:
        file_button.set_name_empty();
    
    var dir = Directory.new();
    dir.open("user://save");
    dir.list_dir_begin();
    
    while true:
        var file_name = dir.get_next();
        if file_name == "":
            break;
        if not file_name.ends_with(".sav"):
            continue;
        var file = File.new();
        file.open("user://save/" + file_name, file.READ);
        file.get_16();
        file.get_16();
        var data = {
            "file_id": file.get_8(),
            "file_name": file.get_pascal_string(),
        };
        file.close();
        print(data.file_id);
        _file_buttons[data.file_id].set_name(data.file_name);
        _file_buttons[data.file_id].set_path("user://save/" + data.file_name);
    
    dir.list_dir_end();

func _file_button_pressed(file_button):
    _last_pressed_file_button = file_button;
    _delete_button.disabled = false;
    _select_button.disabled = false;

func _delete_button_pressed():
    var dir = Directory.new();
    dir.remove(_last_pressed_file_button.get_path());
    _reload_files();
    _disable_buttons();

func _select_button_pressed():
    _disable_buttons();
    get_parent().queue_free();
    if _last_pressed_file_button.has_data():
        var level_controller_scene_instance = ResourceLoader.load(Statics.level_controller_path).instance();
        get_node("/root").add_child(level_controller_scene_instance);
        get_tree().current_scene = level_controller_scene_instance;
        level_controller_scene_instance.set_data(_last_pressed_file_button.get_data());
    else:
        var name_entry_scene_instance = ResourceLoader.load(Statics.name_entry_scene_path).instance();
        get_node("/root").add_child(name_entry_scene_instance);
        get_tree().current_scene = name_entry_scene_instance;
        name_entry_scene_instance.set_file_id(_last_pressed_file_button.get_id());

func _disable_buttons():
    _delete_button.disabled = true;
    _select_button.disabled = true;