extends Node

var _pos;
var _dict;
var _session_set;

func init_dialogue(dialogue_component):
    var file = File.new();
    file.open(dialogue_component.dialogue_json_path, file.READ);
    var text = file.get_as_text();
    _dict = parse_json(text);
    file.close();
    _pos = 0;
    $"../dialogue_container/SpeakerText".set_text(dialogue_component.speaker_name);
    _session_set = [];

func _present_line(content, divert):
    _pos = int(divert);
    $"../dialogue_container".set_visible(true);
    $"../dialogue_container/DialogueText".set_text(content);

func step_dialogue():
    if _pos == -1:
        $"../dialogue_container".set_visible(false);
        _pos = 0;
        return;
    for i in range(_pos, _dict.size()):
        var item = _dict[str(i)];
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