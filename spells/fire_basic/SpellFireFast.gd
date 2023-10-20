extends Spell

var is_can_shoot := true

onready var _shooting_timer: Timer = $ShootingTimer
onready var _reload_timer: Timer = $ReloadTimer


func _ready() -> void:
	_shooting_timer.connect("timeout", self, "_on_ShootineTimer_timeout")
	_reload_timer.connect("timeout", self, "_on_ReloadTimer_timeout")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		_shooting_timer.start()
	elif event.is_action_released("shoot"):
		_reload_timer.start()


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and _cooldown_timer.is_stopped() and is_can_shoot:
		_cooldown_timer.start()
		shoot()


func _on_ShootineTimer_timeout() -> void:
	is_can_shoot = false


func _on_ReloadTimer_timeout() -> void:
	is_can_shoot = true
