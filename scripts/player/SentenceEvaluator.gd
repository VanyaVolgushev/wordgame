extends Node

const EvaluationAttribute = preload("res://scripts/player/Evaluation.gd").EvaluationAttribute

var _evaluations_file_path: String = "user://evaluations.csv"

var _file: FileAccess
var _preloaded_evaluations: Dictionary[String, Evaluation]


func _ready() -> void:
	_file = FileAccess.open(_evaluations_file_path, FileAccess.READ_WRITE)
	_preloaded_evaluations = _preload_evaluations()

func get_evaluation(sentence: String) -> Evaluation:
	if _preloaded_evaluations.has(sentence):
		return _preloaded_evaluations[sentence]
	else:
		return await _get_user_evaluation(sentence)

func _get_user_evaluation(sentence: String) -> Evaluation:
	get_tree().paused = true
	var popup: UserEvaluationPopup = get_tree().get_first_node_in_group("UI").create_user_evaluation_popup()
	popup.init_with_sentence(sentence)
	var evaluation_str: String = await popup.user_evaluation_completed as String
	var evaluation = _string_to_evaluation(evaluation_str)
	_preloaded_evaluations[sentence] = evaluation
	_file.store_line(",".join(sentence.split(" ")) + ";" + evaluation_str)
	get_tree().paused = false
	popup.queue_free()
	return _string_to_evaluation(evaluation_str)

func _string_to_evaluation(evaluation_str: String) -> Evaluation:
	var attr_str_array = evaluation_str.split(",")
	var attribute_array: Array[int] = []
	for attr_str in attr_str_array:
		attribute_array.append(int(attr_str))
	return Evaluation.new(attribute_array)

func _preload_evaluations() -> Dictionary[String, Evaluation]:
	_file = FileAccess.open(_evaluations_file_path, FileAccess.READ_WRITE)
	var read_evaluations: Dictionary[String, Evaluation] = {}

	if _file != null:
		var first_line = true
		while not _file.eof_reached():
			if first_line:
				# Skip the header line
				_file.get_line()
				first_line = false
				continue
			var line = _file.get_line().strip_edges()
			# format: "hello,I,am,friendly,…;1,2,-1,…\n"
			if line == "": continue
			var parts = line.split(";")
			var sentence = " ".join(parts[0].split(","))
			var evaluation_string = parts[1]
			read_evaluations[sentence] = _string_to_evaluation(evaluation_string)
		return read_evaluations
	elif FileAccess.get_open_error() == ERR_FILE_NOT_FOUND:
		# Create an empty file if it doesn't exist
		_file = FileAccess.open(_evaluations_file_path, FileAccess.WRITE_READ)
		var _header = "sentence;" + ",".join(EvaluationAttribute.keys()) + "\n"
		_file.store_line(_header) # Header line
		return {}
	else:
		printerr("Error opening evaluations file:", _file.get_error())
		return {}
