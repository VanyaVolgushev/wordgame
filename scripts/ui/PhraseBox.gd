extends PanelContainer

@export var text_label: Label
@export var voice_stream: VoiceAudioStreamPlayer
var target: Node3D

func _process(_delta):
	var camera = get_viewport().get_camera_3d()
	var world_pos = target.global_transform.origin
	var screen_pos = camera.unproject_position(world_pos)
	position = screen_pos + Vector2(0, -50)

func init(new_target: Node3D, text: String):
	self.text_label.text = text
	self.target = new_target
	target.add_child(voice_stream)
	voice_stream.connect("saying_characters", func(pos: int) -> void: self.text_label.visible_characters = pos)
	#voice_stream.connect("saying_characters", func(pos: int) -> void: head_animation_player.play("saying"))
	voice_stream.connect("finished_saying", func() -> void: self.queue_free())
	voice_stream.connect("finished_saying", func() -> void: voice_stream.queue_free())
	voice_stream.say(text)
