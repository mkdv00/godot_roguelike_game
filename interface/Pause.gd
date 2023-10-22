# The pause screen. It should exist in the main game scene but start hidden.
#
# Pressing the "pause" input action will show this screen and pause everything
# else.
extends Control

# Changing this variable not only pauses and unpauses the game but it also
# toggles the pause screen's visibility.
#
# We achieve that thanks to the set_paused() setter function.
var paused := false setget set_paused

onready var _button_continue := $CenterContainer/VBoxContainer/ContinueButton
onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton


func _ready() -> void:
	# Whenever we presse the continue button, we call the set_paused() function
	# with an argument of false.
	_button_continue.connect("pressed", self, "set_paused", [false])
	_button_restart.connect("pressed", self, "_restart_game")
	_button_quit.connect("pressed", get_tree(), "quit")


# Pressing the pause_toggle action toggles between the paused and unpaused
# states.
func _input(event: InputEvent) -> void:
	if event.is_action_released("pause_toggle"):
		set_paused(not paused)


# Pauses and unpauses everything, except for nodes that have their pause_mode
# set to "process." The PauseScreen itself is set to process, so it will not
# freeze when the SceneTree pauses.
func set_paused(new_pause_state: bool) -> void:
	paused = new_pause_state

	visible = paused
	get_tree().paused = paused
	# When opening the pause menu, we select the continue button
	if visible:
		_button_continue.grab_focus()
	
	AudioServer.set_bus_effect_enabled(1, 0, paused)


func _restart_game() -> void:
	set_paused(false)
	get_tree().reload_current_scene()
