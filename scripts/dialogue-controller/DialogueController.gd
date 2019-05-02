extends Node

var _pos;
var _dict;
var _session_set;
var _finish_action;

func init_dialogue(dialogue_component):
    var file = File.new();
    file.open(dialogue_component.dialogue_json_path, file.READ);
    var text = file.get_as_text();
    _dict = parse_json(text);
    file.close();
    _pos = 0;
    $"../dialogue_container/SpeakerText".set_text(dialogue_component.speaker_name);
    _session_set = [];
    _finish_action = "NONE";

func _present_line(content, divert):
    _pos = int(divert);
    $"../dialogue_container".set_visible(true);
    $"../dialogue_container/DialogueText".set_text(content);

func step_dialogue():
    if _pos == -1:
        $"../dialogue_container".set_visible(false);
        _pos = 0;
        match _finish_action:
            "FIGHT":
                var fight_scene_resource = ResourceLoader.load(Statics.fight_scene_path);
                var fight_scene = fight_scene_resource.instance();
                var level_scene = get_tree().current_scene;
                fight_scene.set_return_scene(level_scene);
                get_node("/root").add_child(fight_scene);
                get_tree().current_scene = fight_scene;
                get_node("/root").remove_child(level_scene);
            "NONE":
                pass;
        return;
    for i in range(_pos, _dict.size()):
        var item = _dict[str(i)];
        if item.has("new_finish_action"):
            _finish_action = item.new_finish_action;
        match item.condition:
            "NOT_READ":
                # todo
                _present_line(item.content, item.pass_divert);
                break;
            "NOT_READ_IN_DIALOGUE_SESSION":
                if _session_set.has(i):
                    i = item.fail_divert;
                else:
                    _present_line(item.content, item.pass_divert);
                    _session_set.append(i);
                    break;
            "NONE":
                _present_line(item.content, item.pass_divert);
                break;