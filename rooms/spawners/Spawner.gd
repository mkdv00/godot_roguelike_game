class_name Spawner
extends Sprite

export(Array, PackedScene) var list := []
export(float, 0.0, 100.0) var spawn_chance := 60.0


func _ready() -> void:
	randomize()
	texture = null


func spawn() -> void:
	if not list:
		return
	
	# Chance to spawn the enemy
	var chance_to_spawn := rand_range(0.0, 99.0) <= spawn_chance
	if not chance_to_spawn:
		return
	
	var random_scene_index := randi() % list.size()
	var scene: PackedScene = list[random_scene_index]
	
	if not scene:
		return
	
	var node: Node2D = scene.instance()
	get_parent().add_child(node)
	node.global_position = global_position
