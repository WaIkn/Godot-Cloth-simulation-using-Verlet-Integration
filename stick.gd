extends Line2D
class_name Stick

static var SCENE := preload("res://Scenes/stick.tscn")
var nodes = Array()

static var length : float

static func set_length(len):
	length = len

func init_nodes(n1 : VerletNode2D, n2 : VerletNode2D) -> void:
	nodes.append(n1)
	nodes.append(n2)
	
func set_nodes(n1 : VerletNode2D, n2 : VerletNode2D) -> void:
	nodes[0] = n1
	nodes[1] = n2

func set_points_position(p1 : Vector2, p2 : Vector2) -> void:
	set_point_position(0, p1)
	set_point_position(1, p2)

func update_positions(n1 = nodes[0], n2 = nodes[1]):
	set_points_position(n1.position, n2.position)

func _process(delta: float) -> void:
	update_positions()
	constrain()


func constrain():
	var distance = nodes[0].position.distance_to(nodes[1].position)
	if distance != length:
		var dd = length - distance
		var direction = nodes[0].position.direction_to(nodes[1].position)
		if !nodes[0].fixed:
			nodes[0].position -= direction * dd / 2
		if !nodes[1].fixed:
			nodes[1].position += direction * dd / 2
		
		
		
		
		
		

	
