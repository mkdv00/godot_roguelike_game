# Floating shield that orbits around the player and ignores walls. Has a Cannon
# that shoots bullets at the player.
extends Mob

# ANCHOR: cannon
onready var _cannon := $Cannon
# END: cannon


# ANCHOR: _physics_process_definition
func _physics_process(delta: float) -> void:
# END: _physics_process_definition
	# ANCHOR: if_not_target
	if not _target:
			return
	# END: if_not_target

	# Turns the cannon towards the player.
	# ANCHOR: look_at
	_cannon.look_at(_target.global_position)
	# END: look_at

	# ANCHOR: if_target_within_range
	if _target_within_range:
			orbit_target()
			# We can call this on every frame, it's not a problem; if the
			# _before_attack_timer is already started, nothing will happen (on most
			# frames, this function does nothing)
			_prepare_to_attack()
	# END: if_target_within_range
	# If the target is not within attack range, we move towards it.
	# ANCHOR: else_follow
	else:
			follow(_target.global_position)
	# END: else_follow


# ANCHOR: _prepare_to_attack
func _prepare_to_attack() -> void:
	if not is_ready_to_attack():
		return
	_before_attack_timer.start()
# END: _prepare_to_attack


# ANCHOR: _on_BeforeAttackTimer_timeout
# The wind-up timer has finished, we can attack.
func _on_BeforeAttackTimer_timeout() -> void:
	# The target might have exited the range while the timeout was running, so
	# we check again
	if not _target:
		return
	# Finally, we shoot.
	_cannon.shoot_at_target(_target)
	_cooldown_timer.start()
# END: _on_BeforeAttackTimer_timeout
