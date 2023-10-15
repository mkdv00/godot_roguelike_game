# The pause screen. It should exist in the main game scene but start hidden.
#
# Pressing the "pause" input action will show this screen and pause everything
# else.
extends Control

onready var _button_continue := $CenterContainer/VBoxContainer/ContinueButton
onready var _button_restart := $CenterContainer/VBoxContainer/RestartButton
onready var _button_quit := $CenterContainer/VBoxContainer/QuitButton


func _ready() -> void:
	_button_quit.connect("pressed", self, "_on_button_quit_pressed")


func _on_button_quit_pressed() -> void:
	get_tree().quit()
