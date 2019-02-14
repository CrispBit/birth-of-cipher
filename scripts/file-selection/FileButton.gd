extends TextureButton

export var _id = 0;

var _name = null;
var _path = "";

func _ready():
    if !_name:
        set_name_empty();
    else:
        set_name(_name);

func set_name(var file_name):
    get_node("RichTextLabel").bbcode_text = "[center]" + file_name + "[/center]";
    _name = file_name;

func set_name_empty():
    set_name("Empty");
    _name = null;

func get_name():
    return _name;

func set_path(var path):
    _path = path;

func get_path():
    return _path;

func set_id(var id):
    _id = id;

func get_id():
    return _id;