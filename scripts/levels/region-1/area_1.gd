extends Spatial

func _process(delta):
    for hacker in get_tree().get_nodes_in_group("interactable"):
        hacker.look_at(2 * hacker.global_transform.origin - $Player/MeshInstance.global_transform.origin, Vector3(0, 1, 0));