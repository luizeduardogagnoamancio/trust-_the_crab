extends Area2D

@export_multiline var hint_text: String = "Hello! I am a very confused crab."

@onready var speech_bubble: NinePatchRect = $SpeechBubble
@onready var label: Label = $SpeechBubble/Label

var is_player_near: bool = false

func _ready() -> void:
	speech_bubble.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		is_player_near = false
		speech_bubble.hide() 

func _input(event: InputEvent) -> void:
	if is_player_near and event.is_action_pressed("interact") and not speech_bubble.visible:
		talk_to_player()
	elif is_player_near and event.is_action_pressed("interact") and speech_bubble.visible:
		speech_bubble.hide()

func talk_to_player() -> void:
	label.text = hint_text

	speech_bubble.show()
