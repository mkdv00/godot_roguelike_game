# Fires an ice fist on the frames the player presses the shoot action unless
# the spell is on cooldown.
class_name SpellIce
extends Spell


# ANCHOR:input
# You can either use the unhandled input function or a process function with
# Input.is_action_just_pressed() to achieve this. Either is fine.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and _cooldown_timer.is_stopped():
		_cooldown_timer.start()
		shoot()
# END:input
