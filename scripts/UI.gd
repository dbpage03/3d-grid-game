extends Control

signal play
signal quit

func _ready():
	get_node("Main Menu").show()
	get_node("Respawn").hide()
	pass

func _on_BtnPlay_pressed():
	get_node("Main Menu").hide()
	emit_signal("play")


func _on_BtnQuit_pressed():
	emit_signal("quit")
	#save?
	get_tree().quit()


func _on_Player_death():
	get_node("Player").hide()
	get_node("Respawn").show()


func _on_BtnRespawn_pressed():
	emit_signal("play")
	get_node("Respawn").hide()


func _on_BtnMenu_pressed():
	get_node("Main Menu").show()
	get_node("Respawn").hide()
