extends Line2D
class_name Rope2D

@onready var nodes := Array()
var spacing : float

static var SCENE = preload("res://Scenes/rope_2d.tscn")

func _ready():
	position = Vector2.ZERO

func _process(delta):
	update_points()
	constrain()

func constrain():
	
	for i : int in nodes.size() - 1:
		var dd = (nodes[i].position.distance_to(nodes[i+1].position) - spacing) / spacing
		nodes[i].constrain_with(nodes[i+1], dd )
		

func update_points():
	for i in nodes.size():
		set_point_position(i, nodes[i].position)

static func create(pos, parent, length, nb_nodes, direction = Vector2.RIGHT):
	var new_rope = SCENE.instantiate() as Rope2D
	var space = get_spacing(length, nb_nodes)
	new_rope.position = pos
	parent.add_child(new_rope)
	for i in nb_nodes :
		if i == 0:
			new_rope.nodes.append(VerletNode2D.create(pos + direction * space * i, new_rope, true))
			
		else:
			new_rope.nodes.append(VerletNode2D.create(pos + direction * space * i, new_rope))
			
		new_rope.add_point(Vector2.ZERO)
	return new_rope
		

static func create_fl(start_node : VerletNode2D, last_node : VerletNode2D, parent, length, nb_nodes, direction = Vector2.RIGHT):
	var new_rope = SCENE.instantiate() as Rope2D
	new_rope.spacing = get_spacing(length, nb_nodes - 1)
	new_rope.nodes.append(start_node)
	parent.add_child(new_rope)
	new_rope.nodes.append(start_node)
	new_rope.add_point(Vector2.ZERO)
	for i in range(1,nb_nodes - 1):
		new_rope.nodes.append(VerletNode2D.create(start_node.global_position + direction * new_rope.spacing * i, new_rope))	
		new_rope.add_point(Vector2.ZERO)
	new_rope.nodes.append(last_node)	
	new_rope.add_point(Vector2.ZERO)
	return new_rope
	
static func get_spacing(length, nb_nodes) -> float:
	return length / (nb_nodes)

func color_debug(stress):
	var clr = lerp(Color.BLACK, Color.RED, stress * 100)
	self_modulate = clr

func get_last():
	return nodes[nodes.size()-1]

func get_first():
	return nodes[0]
