extends Node

var _pos;
var _dict;
var _session_set;
var _finish_action;
var _speaker_name;

func init_dialogue(dialogue_component):
    var file = File.new();
    file.open(dialogue_component.dialogue_json_path, file.READ);
    var text = file.get_as_text();
    _dict = parse_json(text);
    file.close();
    _pos = 0;
    _speaker_name = dialogue_component.speaker_name;
    _session_set = [];
    _finish_action = "NONE";

func _present_line(content, divert, player_speaking):
    _pos = int(divert);
    $"../dialogue_container".set_visible(true);
    $"../dialogue_container/DialogueText".set_text(content);
    if player_speaking == true:
        $"../dialogue_container/SpeakerText".set_text("Three");
    else:
        $"../dialogue_container/SpeakerText".set_text(_speaker_name);

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
        var player_speaking = false;
        if item.has("player_character_speaking") and item.player_character_speaking == "true":
            player_speaking = true;
        match item.condition:
            "NOT_READ":
                # todo
                _present_line(item.content, item.pass_divert, player_speaking);
                break;
            "NOT_READ_IN_DIALOGUE_SESSION":
                if _session_set.has(i):
                    i = item.fail_divert;
                else:
                    _present_line(item.content, item.pass_divert, player_speaking);
                    _session_set.append(i);
                    break;
            "NONE":
                _present_line(item.content, item.pass_divert, player_speaking);
                break;