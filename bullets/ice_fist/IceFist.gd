extends Bullet

onready var _sprite := $Sprite
onready var _particles := $IceSplashParticles2D


# By default, the bullets will instantly get destroyed and disappear from the
# scene, leaving no time for the audio to play and the particles to finish
# emitting.
#
# To give the particles the time to disappear, we call queue_free() when the
# audio finished playing.
# ANCHOR: ready
func _ready() -> void:
	_audio.connect("finished", self, "queue_free")
# END: ready


# We need to override the _destroy() function to emit the particles when hitting
# something.
#
# We also call _disable() to disable collisions and stop moving.
# ANCHOR: destroy
func _destroy() -> void:
	_disable()
	_particles.emitting = true
	_sprite.hide()
	_audio.play()
# END: destroy
