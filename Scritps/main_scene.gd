extends Node2D

@export var size = Vector2(5, 5)
@export var spread = 50.0



func _ready():
	VerletNode2D.setSimulationSpace(%TopLeft.position,%BottomRight.position)
	Stick.set_length(spread)
	
	
	var net = create_net(create_nodes_net())
	
	
	return
	
	
func create_node(targetPosition = $SpawnAnchor.position, fixed = false, previous_position = null):
	var node = VerletNode2D.SCENE.instantiate()
	node.position = targetPosition
	add_child(node)
	node.fixed = fixed
	if previous_position:
		node.previous_position = previous_position
	return node

func create_net(nodes_net, height = size.x, width = size.y):
	var net = Array()
	for h in height:
		for w in width:
			var node = nodes_net[h*width + w]
			if w < width - 1:
				var stick = Stick.SCENE.instantiate()
				stick.init_nodes(node, nodes_net[h * width + w + 1])
				add_child(stick)
				net.append(stick)

			if h < height - 1:
				var stick = Stick.SCENE.instantiate()
				stick.init_nodes(node, nodes_net[(h + 1) * width + w])
				add_child(stick)
				net.append(stick)
					
	return net

func create_nodes_net(height = size.x, width = size.y, fixed_top_side = true):
	var nodes = Array()
	for h in height:
		for w in width:
			var node
			if fixed_top_side and h == 0 and (w == 0 or w == width-1):
				node = create_node($SpawnAnchor.position + Vector2.RIGHT * spread * w + Vector2.DOWN * spread * h, fixed_top_side)
			else:
				node = create_node($SpawnAnchor.position + Vector2.RIGHT * spread * w + Vector2.DOWN * spread * h)
						
			nodes.append(node)
	return nodes
			
		
	
