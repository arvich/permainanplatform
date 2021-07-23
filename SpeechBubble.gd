extends Node2D

onready var text_node = $Anchor/RichTextLabel
onready var text_bg = $Anchor/ColorRect

const char_time = 0.05
const margin_ofset = 8

func _ready() -> void:
	$Area2D.connect('body_entered', self, '_play_animation')
	set_Text("eyyyyyo")

func _play_animation(body):
	$SpeechBubble.play('show')

func set_Text(text, wait_time = 3):
	visible = true

	$Timer.wait_time = wait_time
	$Timer.stop()
	
	text_node.bbcode_text = text
	
	#durasi
	var duration = text_node.text.length() * char_time
	
	#ukuranbalon
	var text_size = text_node.get_font("normal_font").get_string_size(text_node.text)
	text_node.margin_right = text_size.x + margin_ofset
	
	#animasi
	$Tween.remove_all()
	$Tween.interpolate_property(text_node, "percent_visible", 0, 1, duration)
	$Tween.interpolate_property(text_bg, "margin_right", 0, text_size.x + margin_ofset, duration)
	$Tween.start()

func _on_Tween_tween_all_completed() -> void:
	$Timer.start()

func _on_Timer_timeout() -> void:
	visible = false
