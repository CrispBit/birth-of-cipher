extends Control

func disp():
    self.hide()
    
func itemMenuToggle():
    if self.visible:
        self.hide()
    else:
        self.show()

func _ready():
    $ItemList.add_item("Charger", null, true)
    $ItemList.add_item("Pebble", null, true)
    $ItemList.add_item("Dart", null, true)
    $ItemList.add_item("Soda", null, true)
    $ItemList.add_item("Charger+", null, true)
    self.hide()