extends Container

var _data;

func set_data(data):
    _data = data;
    $pause_popup.set_data(data);