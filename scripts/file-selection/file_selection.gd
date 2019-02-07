extends Node

export(ButtonGroup) var file_selection_button_group;
export(NodePath) var delete_button_path;
export(NodePath) var select_button_path;

var _delete_button;
var _select_button;

func _ready():
    _delete_button = get_node(delete_button_path);
    _delete_button.connect("pressed", self, "_delete_button_pressed");
    
    _select_button = get_node(select_button_path);
    _select_button.connect("pressed", self, "_select_button_pressed");

func _process(delta):
    var pressed_file_button = file_selection_button_group.get_pressed_button();
    if (pressed_file_button):
        _delete_button.disabled = false;
        _select_button.disabled = false;

func _delete_button_pressed():
    print("ok");
    _disable_buttons();

func _select_button_pressed():
    get_tree().change_scene(Statics.name_entry_scene_path);
    _disable_buttons();

func _disable_buttons():
    _delete_button.disabled = true;
    _select_button.disabled = true;