extends GridMap

func _ready():
	dirtLayer(3)
	pass

func dirtLayer(var layers):
	var p = self.get_parent().get_node("Player").get_global_transform().origin
	
	for y in range(0,layers-1):
		for x in range(-50,50):
			for z in range(-50,50):
				self.set_cell_item(x,y,z,1)
	grassLayer(layers)
	pass

func grassLayer(var layer):
	for x in range(-50,50):
		for z in range(-50,50):
			self.set_cell_item(x,layer,z,2)
	pass