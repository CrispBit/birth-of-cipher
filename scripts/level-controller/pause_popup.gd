extends Panel

var _data;

func _ready():
    $TabContainer/Basic/Unpause.connect("pressed", self, "_close_popup_menu");

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

func set_data(data):
    _data = data;
    var map_image = Image.new();
    map_image.load("res://images/areas/r" + str(_data.region_id) + "a" + str(_data.area_id) + ".png");
    var map_texture = ImageTexture.new();
    map_texture.create_from_image(map_image);
    $TabContainer/Map/map_texture.texture = map_texture;