extends Node

signal cancel;
signal submit;

export var prompt = "";
export var default_input = "";

export(int) var max_length;

export(NodePath) var cancel_button_path;
export(NodePath) var submit_button_path;

export(NodePath) var input_text_path;

var _cancel_button;
var _submit_button;

var _input_text = RichTextLabel;

var _position;
var _cursor_character = 0;

func _process(delta):
    var letters =       ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
    var letters_lower = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
    var did_something = false;
    if Input.is_action_just_pressed("ui_up"):
        _cursor_character += 1;
        if (_cursor_character >= letters.size()):
            _cursor_character = 0;
        did_something = true;
    if Input.is_action_just_pressed("ui_down"):
        _cursor_character -= 1;
        if (_cursor_character < 0):
            _cursor_character = letters.size() - 1;
        did_something = true;
    if Input.is_action_just_pressed("ui_left"):
        _cursor_character = 0;
        _input_text.text[_position] = "_";
        _position -= 1;
        did_something = true;
    if Input.is_action_just_pressed("ui_right"):
        _input_text.text[_position] = letters_lower[_cursor_character];
        _cursor_character = 0;
        _position += 1;
        did_something = true;
    if (did_something):
        _input_text.text[_position] = letters[_cursor_character];
        _input_text.set_bbcode("[center]" + _input_text.get_text() + "[/center]");

func _ready():
    _position = default_input.length();

    _cancel_button = get_node(cancel_button_path);
    _cancel_button.connect("pressed", self, "_cancel_button_pressed");

    _submit_button = get_node(submit_button_path);
    _submit_button.connect("pressed", self, "_submit_button_pressed");
    
    _input_text = get_node(input_text_path);
    while (_input_text.get_text().length() < max_length):
        _input_text.add_text("_");

func _cancel_button_pressed():
    emit_signal("cancel");

func _submit_button_pressed():
    emit_signal("submit", _input_text.get_text().substr(0, _position));