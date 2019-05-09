extends GridMap

var currentYLevel = 0
var mapX = 8
var mapZ = 8

func _ready():
	pass



func bedrockLayer(var layer = 0):
	currentYLevel = layer
	var p = self.get_parent().get_node("Player").get_global_transform().origin
	currentYLevel += 1
	for x in range(p.x/2-mapX,p.z/2+mapZ):
		for z in range(p.x/2-mapX,p.z/2+mapZ):
			self.set_cell_item(x,layer,z,4)
	stoneLayer()
	pass

func stoneLayer(var layers = 65):
	var p = self.get_parent().get_node("Player").get_global_transform().origin
	
	for y in range(0,layers):
		y = currentYLevel
		currentYLevel += 1
		for x in range(p.x/2-mapX,p.z/2+mapZ):
			for z in range(p.x/2-mapX,p.z/2+mapZ):
				self.set_cell_item(x,y,z,3)
	dirtLayer()
	pass

func dirtLayer(var layers = 3):
	var p = self.get_parent().get_node("Player").get_global_transform().origin
	
	for y in range(0,layers):
		y = currentYLevel
		currentYLevel += 1
		for x in range(p.x/2-mapX,p.z/2+mapZ):
			for z in range(p.x/2-mapX,p.z/2+mapZ):
				self.set_cell_item(x,y,z,1)
	grassLayer()
	pass

func grassLayer():
	var p = self.get_parent().get_node("Player").get_global_transform().origin
	var y = currentYLevel
	currentYLevel += 1
	for x in range(p.x/2-mapX,p.z/2+mapZ):
		for z in range(p.x/2-mapX,p.z/2+mapZ):
			self.set_cell_item(x,y,z,2)
	pass

func _on_UI_play():
	bedrockLayer()
