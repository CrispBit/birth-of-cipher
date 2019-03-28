extends Control
export(int) var Health
export(Texture) var EntityImage

var _Health

func bash():
    _Health -= 2
    get_node("HP").set_text(str(_Health))
    if(_Health < 1):
        get_node("HP").set_text(str(""))
        get_node("HP Label").set_text("Enemy Defeated!")
        $Sprite.hide()

func _ready():
    _Health = Health
    get_node("HP").set_text(str(_Health))
    get_node("Sprite").set_texture(EntityImage)