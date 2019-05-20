extends Node

var y_vel = 0;
var speed = 10
var gravity = .2;
var rotate_speed = deg2rad(200);
var movement_vector = Vector3(0, 0, 0);

static func angle_to_angle(from, to):
    return fposmod(to-from + PI, PI*2) - PI

func _process(delta):
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

    var moving = false;
    if Input.is_action_pressed("move_left"):
        movement_vector.x = -speed;
        moving = true;
    if Input.is_action_pressed("move_up"):
        movement_vector.z = -speed;
        moving = true;
    if Input.is_action_pressed("move_right"):
        movement_vector.x = speed;
        moving = true;
    if Input.is_action_pressed("move_down"):
        movement_vector.z = speed;
        moving = true;
    if moving and $KinematicBody/"Scene Root"/AnimationPlayer.get_current_animation() != "Walking":
        $KinematicBody/"Scene Root"/AnimationPlayer.play("Walking");
    elif not moving and $KinematicBody/"Scene Root"/AnimationPlayer.get_current_animation() != "Idle":
        $KinematicBody/"Scene Root"/AnimationPlayer.play("Idle");
    $KinematicBody.move_and_slide(movement_vector);
    $KinematicBody.move_and_slide(Vector3(0, y_vel * (1+delta), 0));
    
    if not $KinematicBody.is_on_floor():
        y_vel -= gravity * (1+delta);
    else:
        y_vel = 0;
    
    if y_vel < -5:
        y_vel = -5;