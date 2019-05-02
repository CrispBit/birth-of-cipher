extends Control

func disp():
    self.hide()
    
func cast(targ, ind):
    targ.bash()
    $ItemList.remove_item(0)
    
func charge_menu_toggle():
    if self.visible:
        self.hide()
    else:
        self.show()

func _ready():
    $ItemList.add_item("Spark", null, true)
    $ItemList.add_item("Flame", null, true)
    $ItemList.add_item("Sleep", null, true)
    $ItemList.add_item("Suck", null, true)
    $ItemList.add_item("Gun", null, true)
    
    self.hide()
    