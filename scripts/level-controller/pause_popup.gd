extends Panel

func _ready():
    $Unpause.connect("pressed", self, "_close_popup_menu");

func _process(delta):
    if Input.is_action_just_pressed("toggle_pause"):
        get_tree().paused = !get_tree().paused;
        if self.visible:
            self.hide();
        else:
            self.show();

func _close_popup_menu():
    get_tree().paused = false;
    self.hide();