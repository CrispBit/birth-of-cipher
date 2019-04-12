extends Node

var y_vel = 0;
var speed = 10
var gravity = .2;
var rotate_speed = deg2rad(200);
var movement_vector = Vector3(0, 0, 0);

static func angle_to_angle(from, to):
    return fposmod(to-from + PI, PI*2) - PI

func _process(delta):
    if not $KinematicBody/"Scene Root"/AnimationPlayer.is_playing():
        $KinematicBody/"Scene Root"/AnimationPlayer.play("default");
    var angle = 0;
    var B = Vector2(movement_vector.x, -movement_vector.z);
    if B.x != 0 || B.y != 0:
        if B.x == 0:
            if B.y < 0:
                angle = deg2rad(-90);
            elif B.y > 0:
                angle = deg2rad(90);
        else:
            angle = atan(B.y / B.x);
            if B.x < 0:
                angle += deg2rad(180);
            elif B.y > 0:
                angle += deg2rad(360);
        angle += deg2rad(90);
        var old_angle = deg2rad($"KinematicBody/Scene Root".rotation_degrees.y);
        if angle_to_angle(old_angle, angle) > 0:
            old_angle += rotate_speed * delta;
            if angle_to_angle(old_angle, angle) < 0:
                old_angle = angle;
        elif angle_to_angle(old_angle, angle) < 0:
            old_angle -= rotate_speed * delta;
            if angle_to_angle(old_angle, angle) > 0:
                old_angle = angle;
        $"KinematicBody/Scene Root".rotation_degrees.y = rad2deg(old_angle);

func _physics_process(delta):
    movement_vector = Vector3(0, 0, 0);
    
    if Input.is_key_pressed(KEY_LEFT):
        movement_vector.x = -speed;
    if Input.is_key_pressed(KEY_UP):
        movement_vector.z = -speed;
    if Input.is_key_pressed(KEY_RIGHT):
        movement_vector.x = speed;
    if Input.is_key_pressed(KEY_DOWN):
        movement_vector.z = speed;

    $KinematicBody.move_and_slide(movement_vector);
    $KinematicBody.move_and_slide(Vector3(0, y_vel * (1+delta), 0));
    
    if not $KinematicBody.is_on_floor():
        y_vel -= gravity * (1+delta);
    else:
        y_vel = 0;
    
    if y_vel < -5:
        y_vel = -5;