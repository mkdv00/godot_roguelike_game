extends YSort

onready var _spawner := $Mobs/Spawner


func _ready() -> void:
	_spawner.spawn()
