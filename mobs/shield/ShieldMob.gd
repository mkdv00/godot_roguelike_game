extends Mob

onready var _cannon := $Cannon
onready var _line_of_sign := $RayCast2D


func _physics_process(delta: float) -> void:
	if not _target:
		return
	
	_cannon.look_at(_target.global_position)
	_line_of_sign.cast_to = _target.global_position - global_position
	
	if does_see_target():
		attack()
	else:
		_velocity = Vector2.ZERO


func _prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	_before_attack_timer.start()


func attack() -> void:
	if _target_within_range:
		orbit_target()
		_prepare_to_attack()
	else:
		follow(_target.global_position)


func does_see_target() -> bool:
	return _line_of_sign.is_colliding() and _line_of_sign.get_collider() == _target


func _on_BeforeAttackTimer_timeout() -> void:
	if not _target:
		return
	
	_cannon.shoot_at_target(_target)
	_cooldown_timer.start()


func _on_DetectionArea_body_entered(body: Robot) -> void:
	_target = body
	_line_of_sign.enabled = true


func _on_DetectionArea_body_exited(_body: Robot) -> void:
	_target = null
	_line_of_sign.enabled = false
