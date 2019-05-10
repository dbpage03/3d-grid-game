extends GridMap

var currentYLevel = 0
var mapX = 8
var mapZ = 8
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
	stoneLayer()
	pass

func stoneLayer(var layers = 65):
	for y in range(0,layers):
		y = currentYLevel
		currentYLevel += 1
		for x in range(0-mapX,0+mapZ):
			for z in range(0-mapX,0+mapZ):
				self.set_cell_item(x,y,z,3)
	dirtLayer()
	pass

func dirtLayer(var layers = 3):
	for y in range(0,layers):
		y = currentYLevel
		currentYLevel += 1
		for x in range(0-mapX,0+mapZ):
			for z in range(0-mapX,0+mapZ):
				self.set_cell_item(x,y,z,1)
	grassLayer()
	pass

func grassLayer():
	var y = currentYLevel
	currentYLevel += 1
	for x in range(0-mapX,0+mapZ):
		for z in range(0-mapX,0+mapZ):
			self.set_cell_item(x,y,z,2)
	pass
	
	

func _on_UI_play():
	self.clear()
	bedrockLayer()
	worldspawn.y = currentYLevel*2 + 4
	emit_signal("worldready")
