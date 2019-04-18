extends Container

var _data;
enum CONTROLLER {
    MOUSE_KEYBOARD,
    JOYPAD,
}
var controller = CONTROLLER.MOUSE_KEYBOARD;
var _player_entity;
var _last_dialogue_entity;
var _last_interactable_entity;
var _last_interactable_entity_interact_type;
var _interactables;

func set_data(data):
    _data = data;
    $pause_popup.set_data(data);
    _load_level(data.region_id, data.area_id);

func _load_level(region_id, area_id):
    var name_entry_scene_instance = ResourceLoader.load(
            "res://levels/region-" +
            str(region_id+1) +
            "/area_" +
            str(area_id+1) +
            ".tscn"
    ).instance();
    get_node("level_container").add_child(name_entry_scene_instance);
    _player_entity = name_entry_scene_instance.get_node("Player");
    _interactables = get_tree().get_nodes_in_group("interactable");

func _input(event):
    if event is InputEventKey or event is InputEventMouse:
        controller = CONTROLLER.MOUSE_KEYBOARD;
    elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
        controller = CONTROLLER.JOYPAD;
    else: return;
    $controller_icons/keyboard_mouse.visible = false;
    $controller_icons/joypad.visible = false;
    match controller:
        CONTROLLER.MOUSE_KEYBOARD:
            $controller_icons/keyboard_mouse.visible = true;
        CONTROLLER.JOYPAD:
            $controller_icons/joypad.visible = true;
    if Input.is_action_just_pressed("game_interact"):
        if _last_interactable_entity:
            match _last_interactable_entity_interact_type:
                Statics.INTERACT_TYPE.DIALOGUE:
                    if _last_interactable_entity != _last_dialogue_entity:
                        $DialogueController.init_dialogue(_last_interactable_entity.get_node("DialogueComponent"));
                        _last_dialogue_entity = _last_interactable_entity;
                    $DialogueController.step_dialogue();
                Statics.INTERACT_TYPE.NONE:
                    pass

func _process(delta):
    _last_interactable_entity = null;
    for item in $controller_hint_icons/keyboard.get_children():
        item.visible = false;
    for interactable in _interactables:
        var interact_type = interactable.get_interact_type(_player_entity);
        if interact_type != Statics.INTERACT_TYPE.NONE:
            _last_interactable_entity = interactable;
            _last_interactable_entity_interact_type = interact_type;
            for action in InputMap.get_action_list("game_interact"):
                if controller == CONTROLLER.MOUSE_KEYBOARD && action is InputEventKey:
                    get_node("controller_hint_icons/keyboard/" + OS.get_scancode_string(action.scancode)).visible = true;