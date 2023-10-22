extends Mob

onready var _shock_area := $ShockArea


func _ready() -> void:
	_animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	_shock_area.connect("body_entered", self, "_on_ShockArea_body_entered")


func _on_AttackArea_body_entered(body: Robot) -> void:
	_target_within_range = true
	_animation_player.play("will_explode")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "will_explode":
		_disable()
		_die_sound.play()
		_animation_player.play("explode")
	elif anim_name == "RESET":
		_animation_player.play("hover")


func _on_ShockArea_body_entered(body: Node) -> void:
	if body == self:
		return
	
	if body.has_method("take_damage"):
		body.take_damage(damage)
