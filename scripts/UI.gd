extends Control

signal play
signal quit

func _ready():
	pass

func _on_BtnPlay_pressed():
	get_node("Main Menu").hide()
	emit_signal("play")


func _on_BtnQuit_pressed():
	emit_signal("quit")
	#save?
	get_tree().quit()
