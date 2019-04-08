extends RigidBody

var speed = .1

func _ready():
    set_process(true)


func _process(delta):
    if Input.is_key_pressed(KEY_LEFT):
        #print("key left")
        apply_impulse(Vector3(0,0,0),Vector3(-speed,0,0))
    if Input.is_key_pressed(KEY_RIGHT):
        #print("key right")
        apply_impulse(Vector3(0,0,0),Vector3(speed,0,0))
    if Input.is_key_pressed(KEY_UP):
        #print("key up")
        apply_impulse(Vector3(0,0,0),Vector3(0,0,-speed))
    if Input.is_key_pressed(KEY_DOWN):
        #print("key down")
        apply_impulse(Vector3(0,0,0),Vector3(0,0,speed))