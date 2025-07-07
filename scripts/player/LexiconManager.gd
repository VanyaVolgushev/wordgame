extends Node

var _lexicon: Array[LexiconEntry] = []
var _initial_lexicon: Array[LexiconEntry] = [
    LexiconEntry.new("hello"),
    LexiconEntry.new("hi"),
    LexiconEntry.new("goodbye"),
    LexiconEntry.new("thanks"),
    LexiconEntry.new("you"),
]

func _ready() -> void:
    # Temporary initialization of the lexicon
    for entry in _initial_lexicon:
        add_entry(entry)

func get_lexicon() -> Array[LexiconEntry]:
    return _lexicon

func add_entry(entry: LexiconEntry) -> void:
    if entry not in _lexicon:
        _lexicon.append(entry)
    else:
        print("Entry already exists in lexicon: ", entry.string)
