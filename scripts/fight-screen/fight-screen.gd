extends Control

var _return_scene = null;

func set_return_scene(return_scene):
    _return_scene = return_scene;

func win_condition():
    if (get_node("Enemy").get_HP() < 1):
        get_tree().get_current_scene().queue_free();
        get_tree().get_root().add_child(_return_scene);
        get_tree().current_scene = _return_scene;
        _return_scene.handle_fight_win();
        _return_scene = null;

func run():
    get_tree().get_current_scene().queue_free();
    get_tree().get_root().add_child(_return_scene);
    get_tree().current_scene = _return_scene;
    _return_scene.handle_fight_run();
    _return_scene = null;

func _ready():
    $Enemy.connect("after_attacked", self, "win_condition");
    $Bash.connect("pressed", $Enemy, "receive_bash");
    $Bash.connect("pressed", $Entity, "bash");
    $Charge.connect("pressed", $Entity, "charge");
    get_node("Charge").connect("pressed", $ChargeTable, "charge_menu_toggle");
    get_node("Charge").connect("pressed", $ItemTable, "disp");
    get_node("Item").connect("pressed", $ItemTable, "item_menu_toggle");
    get_node("Item").connect("pressed", $ChargeTable, "disp");
    get_node("Run").connect("pressed", self, "run");