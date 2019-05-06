extends Control



func _ready():
	hide()

func _process(delta):
	get_node("HealthBar").value = get_parent().get_parent().get_node("Player").health
	pass


func _on_UI_play():
	show()
