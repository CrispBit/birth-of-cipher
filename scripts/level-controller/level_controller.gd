extends Container

var _data;
enum CONTROLLER {
    mouse_keyboard,
    joypad,
}
var controller = CONTROLLER.mouse_keyboard;

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