# Increases the robot's health when collected.
extends Pickup


func _on_robot_pickup(robot: Robot) -> void:
	robot.health += 2
	_disable()
	_animation_player.play("destroy")
