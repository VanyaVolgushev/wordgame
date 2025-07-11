extends PanelContainer
class_name PhraseBox

@export var _text_label: Label
@export var _voice_stream: VoiceAudioStreamPlayer
@export var _time_bar: Control
@export var _horizontal_size_px: int

var _timer: Timer
var _target: Node3D

signal timeout

func _process(_delta):
	var camera = get_viewport().get_camera_3d()
	var world_pos = _target.global_transform.origin
	var screen_pos = camera.unproject_position(world_pos)
	position = screen_pos + Vector2(0, -50)
	if _timer:
		_time_bar.custom_minimum_size.x = _timer.time_left / _timer.wait_time * _horizontal_size_px

# Could be replaced with a constructor override
func init(new_target: Node3D, text: String, response_time: float) -> void:
	# Say text with my voice stream and connect to its signals.
	self._text_label.text = text
	self._target = new_target
	_voice_stream.connect("saying_characters", func(pos: int) -> void: self._text_label.visible_characters = pos)
	_voice_stream.connect("finished_saying", func() -> void: self._on_finished_saying(response_time))
	_voice_stream.say(text)

func _on_finished_saying(response_time: float) -> void:
	# Create response timer and connect to its timeout signal.
	_timer = Timer.new()
	_timer.wait_time = response_time
	_timer.one_shot = true
	_timer.autostart = true
	_timer.timeout.connect(_on_timeout)
	add_child(_timer)

func _on_timeout() -> void:
	emit_signal("timeout")

func covers_center_of_screen() -> bool:
	# Calculate the viewport’s center point
	var vp_size: Vector2 = get_viewport().get_visible_rect().size
	var center: Vector2 = vp_size * 0.5

	# Build this Control’s global rectangle
	var rect := Rect2(global_position, size)

	# Return true if the center lies within that rect
	return rect.has_point(center)
