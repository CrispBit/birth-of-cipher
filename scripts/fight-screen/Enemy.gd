extends Control
export(int) var health;
export(Texture) var EntityImage;

var _health;
signal after_attacked;

func get_HP():
    return _health;
    
func receive_bash():
    _health -= 2;
    $HP.set_text(str(_health));
    if(_health < 1):
        $HP.set_text(str(""));
        get_node("HP Label").set_text("Enemy Defeated!");
        $Sprite.hide();
    emit_signal("after_attacked");

func _ready():
    _health = health;
    $HP.set_text(str(_health));
    $Sprite.set_texture(EntityImage);