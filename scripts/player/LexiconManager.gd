extends Node

var _lexicon: Array[String] = []
var _initial_lexicon: Array[String] = [
        "hello",
	    "goodbye",
	    "friend",
	    "fuck",
	    "thank",
	    "you",
	    "I",
	    "please"
    ]

func _ready() -> void:
    # Temporary initialization of the lexicon
    for word in _initial_lexicon:
        learn_word(word)

func get_lexicon() -> Array[String]:
    return _lexicon.duplicate()

func learn_word(word: String) -> void:
    if word in _lexicon:
        printerr("Entry already exists in lexicon: ", word)
    elif word not in ExistingWords.general:
        printerr("Word \"", word, "\" is not an existing word")
    else:
        _lexicon.append(word)
