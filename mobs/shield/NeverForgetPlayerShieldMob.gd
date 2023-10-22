extends Mob

onready var _cannon := $Cannon


func _physics_process(delta: float) -> void:
	if not _target:
		return
	
	_cannon.look_at(_target.global_position)
	
	if _target_within_range:
		orbit_target()
		_prepare_to_attack()
	else:
		follow(_target.global_position)


func _prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	_before_attack_timer.start()


func _on_BeforeAttackTimer_timeout() -> void:
	if not _target:
		return
	
	_cannon.shoot_at_target(_target)
	_cooldown_timer.start()


func _on_DetectionArea_body_exited(_body: Robot) -> void:
	_sprite_alert.visible = false
