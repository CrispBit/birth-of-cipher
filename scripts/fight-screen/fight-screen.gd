extends Control

func winCondition():
    if(get_node("Enemy").get_HP() < 1):
        get_tree().change_scene("res://scenes/fight-screen/post-fight.tscn")

func run():
    get_tree().change_scene("res://scenes/fight-screen/post-fight.tscn")

func _ready():
    $Bash.connect("pressed", self, "winCondition")
    $Bash.connect("pressed", $Enemy, "bash")
    $Bash.connect("pressed", $Entity, "bash")
    $Charge.connect("pressed", $Entity, "charge")
    get_node("Charge").connect("pressed", get_node("Charge Table"), "chargeMenuToggle")
    get_node("Charge").connect("pressed", get_node("Item Table"), "disp")
    get_node("Item").connect("pressed", get_node("Item Table"), "itemMenuToggle")
    get_node("Item").connect("pressed", get_node("Charge Table"), "disp")
    get_node("Run").connect("pressed", self, "run")
