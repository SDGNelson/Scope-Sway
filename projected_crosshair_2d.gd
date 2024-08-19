class_name ProjectedCrosshair2D extends Node2D
## Positions itself in the HUD according to a point infinitely(-ish) along the aiming direction.
## (There are other ways to accomplish this, but it's not focus of this example project.)

## Camera to use for world to screen projection.
@export var camera: Camera3D = null

## This node's forward vector indicates the shot direction, and position is the origin of the shot.
@export var aim_node: Node3D = null

func _process(_p_delta: float) -> void:
	var aim_transform: Transform3D = aim_node.global_transform
	var aim_forward: Vector3 = aim_transform.basis.z
	var target_point: Vector3 = aim_transform.origin + aim_forward * 1000.0
	global_position = camera.unproject_position(target_point)
