extends Node2D
class_name Net2D

@onready var ropes := Array()


static var SCENE = preload("res://Scenes/net_2d.tscn")


static func create(pos, parent, height, width, spacing, resolution):
	var new_net = SCENE.instantiate() as Net2D
	Globals.rope_length = spacing
	parent.add_child(new_net)
	var preseted_nodes = preset_nodes(pos, parent, height , width , spacing)
	for h in height:
		for w in width:
			if w < width - 1:
				var rope = Rope2D.create_fl(preseted_nodes[h * width + w],preseted_nodes[h * width + w+1], parent, spacing, resolution, Vector2.RIGHT)
				new_net.ropes.append(rope)
			if h < height - 1:
				var rope = Rope2D.create_fl(preseted_nodes[h * width + w],preseted_nodes[(h+1) * width + w], parent, spacing, resolution, Vector2.DOWN)
				new_net.ropes.append(rope)
				
	pass

static func preset_nodes(pos, parent, height, width, spacing):
	var pnodes = Array()
	for h in height:
		for w in width:
			var fixed = false
			if h == 0 and w%8 == 0:
				fixed = true
			pnodes.append(VerletNode2D.create(pos + Vector2(w * spacing, h * spacing), parent, fixed))
	return pnodes
