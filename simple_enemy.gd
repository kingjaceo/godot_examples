extends Node2D

var _movement_state: MovementState
var _target_direction: Vector2
var _target: Vector2
var _old_position: Vector2
enum MovementState {IDLE, WALK}

# Called when the node enters the scene tree for the first time.
func _ready():
	_change_movement_state(MovementState.WALK)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move_to_target(delta)
	

func _change_movement_state(new_state: MovementState):
	if new_state == MovementState.IDLE:
		_target_direction = Vector2(0, 0) # when we are idle, there is no target direction
	if new_state == MovementState.WALK:
		var choice = [-1, 1]
		_target_direction = Vector2(choice[randi() % len(choice)], 0) # you can set the DIRECTION (relative to this object)
		
	_movement_state = new_state


func _move_to_target(delta):
	position += _target_direction
	

func _on_change_state_timer_timeout():
	if _movement_state == MovementState.WALK:
		_change_movement_state(MovementState.IDLE)
	elif _movement_state == MovementState.IDLE:
		_change_movement_state(MovementState.WALK)
		var choice = randi_range(0, 1)
	$ChangeStateTimer.start()
