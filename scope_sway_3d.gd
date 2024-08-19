@icon("res://scope_sway_3d_icon.svg")
class_name ScopeSway3D extends Node3D
## Rotates itself according to a Lissajous curve: https://en.wikipedia.org/wiki/Lissajous_curve
## For example, this could be the child of a transform rotated according to player mouse/gamepad
## aiming input, and represents the direction the shot will be fired.


## How far away from center to sway.
## This is both A and B in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 45.0, 0.1, "radians_as_degrees")
var amplitude: float = 0.17453334

## Multiplier for how quickly to advance sway time.
## This is a multiplier for t in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10.0, 0.1)
var time_scale: float = 0.5

## Multiplier for time input to vertical rotation.
## This is 'b' in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10.0, 0.1)
var pitch_multiplier: float = 2.0

## Multiplier for time input to horizontal rotation.
## This is 'a' in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10.0, 0.1)
var yaw_multiplier: float = 3.0

## Offset to time input to horizontal rotation. Defaults to half PI.
## This is 'd' in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10.0, 0.001)
var yaw_time_offset: float = 1.5708

# Accumulated process time multiplied by time_scale. The sway offset can be calculated approximately
# deterministically on the server if _sway_time is incremented in a deterministic manner.
var _sway_time_pitch: float = 0.0
var _sway_time_yaw: float = 0.0


func _process(p_delta: float) -> void:
	var sway_delta_time: float = p_delta * time_scale
	_sway_time_pitch += pitch_multiplier * sway_delta_time
	_sway_time_yaw += yaw_multiplier * sway_delta_time
	# Probably overkill, but if this node exists for a long time it's possible _sway_time could start
	# to experience floating point precision issues. To avoid that, we loop back to zero once the cycle
	# is complete. Using two separate time variables is much simpler than finding a common multiple of
	# (TAU/at) and (TAU/bt), if there even is one that wouldn't itself be a big number? If you know
	# the answer to this, I'd love to hear it!
	_sway_time_pitch = fmod(_sway_time_pitch, TAU)
	_sway_time_yaw = fmod(_sway_time_yaw, TAU)
	var pitch: float = amplitude * sin(_sway_time_pitch)
	var yaw: float = amplitude * sin(_sway_time_yaw + yaw_time_offset)
	rotation = Vector3(pitch, yaw, 0.0)
