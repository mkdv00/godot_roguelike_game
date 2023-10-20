extends Bullet

var time := 0.0
var time_offset := 0.6
var exponent := 13.0
var max_speed := 2000

onready var _animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	speed = 0.0
	_animation_player.play("spawn")
	_audio.connect("finished", get_tree(), "queue_free")


func _destroy() -> void:
	_disable()
	_audio.play()
	_animation_player.play("destroy")


func _accelerate_speed(delta: float) -> void:
	time += delta
	speed = max_speed * pow(time + time_offset, exponent)
	speed = min(speed, max_speed)


func _move(delta: float) -> void:
	_accelerate_speed(delta)
	var distance := speed * delta
	var motion := transform.x * speed * delta

	position += motion

	_travelled_distance += distance
	if _travelled_distance > max_range:
		_destroy()
