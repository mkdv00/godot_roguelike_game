extends Control

onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton


func _ready() -> void:
	# In this script, we directly connect the buttons' pressed signal to
	# functions of the SceneTree object. We can do that here because the
	# Button.pressed signal emits with no extra argument.
	#
	# See the GameOver.gd script for a different way of connecting the signals.
	_button_restart.connect("pressed", get_tree(), "change_scene", ["res://Main.tscn"])
	_button_quit.connect("pressed", get_tree(), "quit")

	# Select the button to navigate the menu of the keyboard. 
	# By default, the menu starts with no button selected and the player needs to use the mouse.
	_button_restart.grab_focus()
