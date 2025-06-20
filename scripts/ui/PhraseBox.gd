extends PanelContainer

@export var text_label: Label
@export var voice_stream: VoiceAudioStreamPlayer
var target: Node3D
# signal timeout

func _process(_delta):
	var camera = get_viewport().get_camera_3d()
	var world_pos = target.global_transform.origin
	var screen_pos = camera.unproject_position(world_pos)
	position = screen_pos + Vector2(0, -50)

# I think this is where you'd pass the time you have to respond
func init(new_target: Node3D, text: String):
	self.text_label.text = text
	self.target = new_target
	voice_stream.connect("saying_characters", func(pos: int) -> void: self.text_label.visible_characters = pos)
	#voice_stream.connect("finished_saying", func() -> void: self.queue_free())
	voice_stream.say(text)

func covers_center_of_screen() -> bool:
	# Calculate the viewport’s center point
	var vp_size: Vector2 = get_viewport().get_visible_rect().size
	var center: Vector2 = vp_size * 0.5

	# Build this Control’s global rectangle
	var rect := Rect2(global_position, size)

	# Return true if the center lies within that rect
	return rect.has_point(center)
