extends Container

var _data;
enum CONTROLLER {
    mouse_keyboard,
    joypad,
}
var controller = CONTROLLER.mouse_keyboard;
var _player_entity;
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
        controller = CONTROLLER.mouse_keyboard;
    elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
        controller = CONTROLLER.joypad;
    else: return;
    $level_container/controller_icons/keyboard_mouse.visible = false;
    $level_container/controller_icons/joypad.visible = false;
    match controller:
        CONTROLLER.mouse_keyboard:
            $level_container/controller_icons/keyboard_mouse.visible = true;
        CONTROLLER.joypad:
            $level_container/controller_icons/joypad.visible = true;

func _process(delta):
    for item in $level_container/controller_hint_icons/keyboard.get_children():
        item.visible = false;
    for interactable in _interactables:
        if _player_entity.global_transform.origin.distance_to(interactable.global_transform.origin) <= 4:
            for action in InputMap.get_action_list("game_interact"):
                if controller == CONTROLLER.mouse_keyboard && action is InputEventKey:
                    get_node("level_container/controller_hint_icons/keyboard/" + OS.get_scancode_string(action.scancode)).visible = true;