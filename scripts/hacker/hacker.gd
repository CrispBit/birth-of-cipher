extends Node

func _process(delta):
    if not $RigidBody/"Scene Root"/AnimationPlayer.is_playing():
        $RigidBody/"Scene Root"/AnimationPlayer.play("default");

func can_interact_with(obj):
    return obj.get_node("KinematicBody").global_transform.origin.distance_to($RigidBody.global_transform.origin) <= 4;

func interact():
    pass