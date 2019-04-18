extends Spatial

func _process(delta):
    for hacker in get_tree().get_nodes_in_group("interactable"):
        hacker.get_node("RigidBody").look_at(2 * hacker.get_node("RigidBody").global_transform.origin - $Player.get_node("KinematicBody").global_transform.origin, Vector3(0, 1, 0));
        hacker.get_node("RigidBody").set_rotation(Vector3(0, hacker.get_node("RigidBody").get_rotation().y, 0));