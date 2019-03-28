extends Control
        
func quit():
    get_tree().quit()
    
func finishFight():
    get_tree().change_scene(
    
func chargeSelect(idx):
    if(get_node("Item Table").is_anything_selected()):
        get_node("Item Table").cast(get_node("Enemy"), idx)

func _ready():
    $Bash.connect("pressed", $Enemy, "bash")
    $Bash.connect("pressed", $Entity, "bash")
    $Charge.connect("pressed", $Entity, "charge")
    get_node("Charge").connect("pressed", get_node("Charge Table"), "chargeMenuToggle")
    get_node("Charge").connect("pressed", get_node("Item Table"), "disp")
    get_node("Item").connect("pressed", get_node("Item Table"), "itemMenuToggle")
    get_node("Item").connect("pressed", get_node("Charge Table"), "disp")
    get_node("Run").connect("pressed", get_tree(), "quit")
