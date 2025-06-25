extends Node
class_name Interactor

signal phrasebox_in_center()
signal phrasebox_not_in_center()
signal response_began()
signal response_ended()


func _process(_delta):
    if(_get_phrasebox_in_center()):
        emit_signal("phrasebox_in_center")
    else:
        emit_signal("phrasebox_not_in_center")

func _get_phrasebox_in_center() -> PhraseBox:
    for pb in get_tree().get_nodes_in_group("Phrase Boxes"):
        if pb is Node and pb.covers_center_of_screen():
            return pb
    return null
    
func _unhandled_input(event):
    if event.is_action_pressed("interact"):
        var phrasebox = _get_phrasebox_in_center()
        if phrasebox:
            begin_response(phrasebox)
        
func begin_response(phrase_box: PhraseBox) -> void:
    response_began.emit(phrase_box)
    # This function is called when the player interacts with a phrase box.
    # It can be used to trigger specific responses or actions.
    # For now, we will just print the text of the phrase box.
    print("Responding to phrase box with text: ", phrase_box._text_label.text)
    # You can add more logic here to handle the response, such as triggering animations or events.
