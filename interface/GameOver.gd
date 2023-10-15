extends Control

onready var _quit_button: Button = $CenterContainer/VBoxContainer/QuitButton


func _ready() -> void:
	_quit_button.connect("pressed", self, "_on_quit_button_pressed")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
