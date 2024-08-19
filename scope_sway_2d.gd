@icon("res://scope_sway_2d_icon.svg")
class_name ScopeSway2D extends Node2D
## Positions itself according to a Lissajous curve: https://en.wikipedia.org/wiki/Lissajous_curve
## In scope_demo_2d.tscn this is the child of a control centered in the screen, but it could,
## for example, be the child of a node that follows the cursor so the player has to account for the
## motion relative to their input.


## How far away from center to sway.
## This is both A and B in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10000.0, 1.0, "suffix:px")
var amplitude: float = 100.0

## Multiplier for how quickly to advance sway time.
## This is a multiplier for t in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10.0, 0.1)
var time_scale: float = 0.5

## Multiplier for time input to horizontal position.
## This is 'a' in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10.0, 0.1)
var horizontal_multiplier: float = 3.0

## Multiplier for time input to vertical position.
## This is 'b' in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10.0, 0.1)
var vertical_multiplier: float = 2.0

## Offset to time input to horizontal position. Defaults to half PI.
## This is 'd' in the x = A * sin(a * t + d), y = B * sin(b * t) equation.
@export_range(0.0, 10.0, 0.001)
var horizontal_time_offset: float = 1.5708

# Accumulated process time multiplied by time_scale. The sway offset can be calculated approximately
# deterministically on the server if _sway_time is incremented in a deterministic manner.
var _sway_time_x: float = 0.0
var _sway_time_y: float = 0.0


func _process(p_delta: float) -> void:
	var sway_delta_time: float = p_delta * time_scale
	_sway_time_x += horizontal_multiplier * sway_delta_time
	_sway_time_y += vertical_multiplier * sway_delta_time
	# Probably overkill, but if this node exists for a long time it's possible _sway_time could start
	# to experience floating point precision issues. To avoid that, we loop back to zero once the cycle
	# is complete. Using two separate time variables is much simpler than finding a common multiple of
	# (TAU/at) and (TAU/bt), if there even is one that wouldn't itself be a big number? If you know
	# the answer to this, I'd love to hear it!
	_sway_time_x = fmod(_sway_time_x, TAU)
	_sway_time_y = fmod(_sway_time_y, TAU)
	var x: float = amplitude * sin(_sway_time_x + horizontal_time_offset)
	var y: float = amplitude * sin(_sway_time_y)
	position = Vector2(x, y)
