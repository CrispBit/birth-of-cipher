extends Node

func _process(delta):
    if not $RigidBody/"Scene Root"/AnimationPlayer.is_playing():
        $RigidBody/"Scene Root"/AnimationPlayer.play("default");

func get_interact_type(obj):
    if (obj.get_node("KinematicBody").global_transform.origin.distance_to($RigidBody.global_transform.origin) <= 10):
        return Statics.INTERACT_TYPE.DIALOGUE;
    return Statics.INTERACT_TYPE.NONE;