## Takes care of showing the UI. Should be always present. Uses the global event
## bus to update itself
extends Control

# The score is only displayed in the interface, because we're not saving it
# anywhere or doing anything with it. If we wanted to save it, we'd extract it
# to some custom resource
# ANCHOR: header
var _score := 0

onready var _health_bar := $HealthBar
onready var _score_label := $ScoreLabel
# END: header
onready var _selected_spell_icon := $SelectedSpellIcon

# ANCHOR: ready
func _ready() -> void:
	# set the score to 0 at the beginning
	_set_score(0)
	# Connect to the global event bus
	Events.connect("mob_died", self, "_on_Events_mob_died")
	Events.connect("player_health_changed", self, "_on_player_health_changed")
# END: ready
	Events.connect("selected_spell_changed", self, "_on_selected_spell_changed")


# ANCHOR: set_score
# Run to update the score and the label
func _set_score(new_score: int) -> void:
	_score = new_score
	_score_label.text = str(_score).pad_zeros(5)
# END: set_score


# ANCHOR: mob_died
# This function runs when the global event bus emits a "mob_died" signal
func _on_Events_mob_died(mob_score_value: int) -> void:
	_set_score(_score + mob_score_value)
# END: mob_died


# ANCHOR: player_health_changed
# This function runs when the global event bus emits a "player_health_changed" signal
func _on_player_health_changed(health: int) -> void:
	_health_bar.health = health
# END: player_health_changed


# This function runs when the global event bus emits a "selected_spell_changed" signal
func _on_selected_spell_changed(spell_scene: PackedScene) -> void:
	_selected_spell_icon.set_current_spell_from_scene(spell_scene)
