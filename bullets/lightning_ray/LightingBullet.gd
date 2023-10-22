extends Bullet

onready var _animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	_animation_player.play("spawn")
	_audio.connect("finished", get_tree(), "queue_free")


func _destroy() -> void:
	_disable()
	_audio.play()
	_animation_player.play("destroy")
