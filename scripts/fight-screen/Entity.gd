extends Control
export(int) var Charge

var _Charge
var _affected

export(Texture) var EntityImage

func bash():
    _Charge += 2
    if(_Charge > 30):
        get_node("Charge Label").set_text("Overcharged!")
        $Sprite.hide()
    if(_Charge > 0 && _Charge <= 30):
        get_node("Status Label").set_text("")
        get_node("Charge").set_text(str(_Charge))
    else:
        get_node("Charge").set_text("")

func charge():
    _Charge -= 5
    if(_Charge <= 0):
        get_node("Status Label").set_text("")
        get_node("Charge").set_text("")
        get_node("Charge Label").set_text("Depleted!")
        $Sprite.hide()
    if(_Charge > 0 && _Charge <= 30):
        get_node("Status Label").set_text("")
        get_node("Charge").set_text(str(_Charge))
    
func statusUpdate():
    if(!_affected):
        get_node("Status Label").set_text("Cured of status effect")
        _affected = true
    else:
        get_node("Status Label").set_text("Poisoned!")
        _affected = false
        
func _ready():
    _Charge = Charge
    get_node("Charge").set_text(str(_Charge))
    get_node("Sprite").set_texture(EntityImage)