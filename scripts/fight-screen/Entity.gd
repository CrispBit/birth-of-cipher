extends Control
export(int) var charge;

var _charge;
var _affected;
signal after_attack;

export(Texture) var EntityImage

func bash():
    _charge += 2;
    if(_charge > 30):
        get_node("Charge Label").set_text("Overcharged!");
        $Sprite.hide();
    if(_charge > 0 && _charge <= 30):
        get_node("Status Label").set_text("");
        $Charge.set_text(str(_charge));
    else:
        $Charge.set_text("");
    emit_signal("after_attack");

func charge():
    _charge -= 5
    if (_charge <= 0):
        get_node("Status Label").set_text("");
        $Charge.set_text("");
        get_node("Charge Label").set_text("Depleted!");
        $Sprite.hide();
    if (_charge > 0 && _charge <= 30):
        get_node("Status Label").set_text("");
        $Charge.set_text(str(_charge));
    
func status_update():
    if(!_affected):
        get_node("Status Label").set_text("Cured of status effect");
        _affected = true
    else:
        get_node("Status Label").set_text("Poisoned!");
        _affected = false
        
func _ready():
    _charge = charge;
    $Charge.set_text(str(_charge));
    $Sprite.set_texture(EntityImage);