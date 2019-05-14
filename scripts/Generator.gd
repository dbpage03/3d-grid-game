extends GridMap

var currentYLevel = 0
var mapX = 20
var mapZ = 20
var worldspawn = Vector3()
signal worldready

func _ready():
	pass

func bedrockLayer(var layer = 0):
	currentYLevel = layer
	currentYLevel += 1
	for x in range(0-mapX,0+mapZ):
		for z in range(0-mapX,0+mapZ):
			self.set_cell_item(x,layer,z,4)
		yield(get_tree().create_timer(0),"timeout")
	stoneLayer()
	pass

func stoneLayer(var layers = 65):
	for y in range(0,layers):
		y = currentYLevel
		currentYLevel += 1
		for x in range(0-mapX,0+mapZ):
			for z in range(0-mapX,0+mapZ):
				self.set_cell_item(x,y,z,3)
			yield(get_tree().create_timer(0),"timeout")
	dirtLayer()
	pass

func dirtLayer(var layers = 3):
	for y in range(0,layers):
		y = currentYLevel
		currentYLevel += 1
		for x in range(0-mapX,0+mapZ):
			for z in range(0-mapX,0+mapZ):
				self.set_cell_item(x,y,z,1)
			yield(get_tree().create_timer(0),"timeout")
	grassLayer()
	pass

func grassLayer():
	var y = currentYLevel
	currentYLevel += 1
	for x in range(0-mapX,0+mapZ):
		for z in range(0-mapX,0+mapZ):
			self.set_cell_item(x,y,z,2)
		yield(get_tree().create_timer(0),"timeout")
	
	worldspawn.y = currentYLevel*2 + 4
	emit_signal("worldready")
	pass
	
	

func _on_UI_play():
	#self.clear()
	bedrockLayer()
