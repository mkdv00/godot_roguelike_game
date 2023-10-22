# Auto-loaded node that only emits signals.
#
# Any node in the game can use it to emit signals, like so:
#
# Events.emit_signal("mob_died", 10)
#
# Any node in the game can connect to the events:
#
# Events.connect("mob_died", self, "_on_Events_mob_died")
#
# This allows nodes to easily communicate accross the project without needing to
# know about each other. We mainly use it to update the heads-up display, like
# the player's health and score.
extends Node

signal mob_died(score_value)
signal player_health_changed(new_health)
signal selected_spell_changed(new_selected_spell_scene)
