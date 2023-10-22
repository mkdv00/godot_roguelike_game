# Main and first scene of the project
#
# Takes care of:
#
# 1. Spawning the rooms
# 2. Hiding the Pause UI
extends YSort

# The list of possible rooms to spawn
export(Array, PackedScene) var rooms := []
# The amount of rooms on the x axis
export var grid_width := 2
# The amount of rooms on the y axis
export var grid_height := 2
# The size of each individual room. It's assumed that all the rooms in the 
# `rooms` array have that size.
export var room_size := Vector2(13, 13) * 128

# A UI screen that handles pausing
onready var _pause_screen := $UILayer/PauseScreen
# An audio player for the background music
# It uses the `RandomAudioPlayer` so it will pick a random track every time
onready var _music_player := $MusicPlayer


func _ready() -> void:
	randomize()
	_pause_screen.hide()
	_music_player.play()
	generate_level()


func generate_level() -> void:
	# We need to know which is the first and which is the last room, so we can 
	# spawn the robot in the first, and the teleporter in the last
	var last_room_index := (grid_width * grid_height)  - 1
	# We keep an current_room_index to count the rooms
	var current_room_index := 0
	for x in grid_width:
		for y in grid_height:
			var room_position := Vector2(x, y)
			
			var RoomScene: PackedScene = rooms[randi() % rooms.size()]
			var room: BaseRoom = RoomScene.instance()
			
			room.global_position = room_size * room_position
			add_child(room)

			# In the first room, we don't want mobs, and we need to spawn the player.
			if current_room_index == 0:
				room.spawn_robot()
				room.spawn_items()
			# In the last room, we don't spawn items not to overcrowd it.
			elif current_room_index == last_room_index:
				room.spawn_teleporter()
				room.spawn_mobs()
			# For all other rooms, we spawn both items and mobs.
			else:
				room.spawn_mobs()
				room.spawn_items()
			
			# We hide bridges when there are no connected rooms.
			if x == 0:
				room.hide_left_bridge()
			elif x == grid_width - 1:
				room.hide_right_bridge()
			if y == 0:
				room.hide_top_bridge()
			elif y == grid_height - 1:
				room.hide_bottom_bridge()
			
			current_room_index += 1
