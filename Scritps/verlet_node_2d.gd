extends Node2D
class_name VerletNode2D

@onready var previous_position := position
@onready var acceleration := Globals.GRAVITY
@onready var is_fixed := false

var id : int
var damping = 0.99


static var number_of_instances := 0
static var SCENE := preload("res://Scenes/verlet_node_2d.tscn")

var constrain_queue = Array()

func _ready() -> void:
	pass
	
func _process(delta) -> void:
	update_acceleration(delta)
	if is_fixed:
		return
	
	var next_position = next_position_verlet(delta)
	previous_position = position 
	
	
	
	position = next_position

func update_acceleration(delta):
	acceleration = Globals.GRAVITY + WindArea.get_wind_at(position.x, position.y, delta)

func next_position_verlet(delta) -> Vector2:
		return position + (position - previous_position) * damping + acceleration * delta * delta
		

func constrain_with(node, dd ):
	color_debug(dd)
	var weighting = 2.0
	var temp_position = position
	if node.is_fixed:
		weighting -= 1
	if is_fixed:
		weighting -= 1
	
	var direction = position.direction_to(node.position)
	if !is_fixed:
		position +=  direction * dd * 5 / weighting 
	if !node.is_fixed:
		node.position -= direction * dd * 5 / weighting 

		


	
static func create(pos, parent, fixed = false):

	var new_node = SCENE.instantiate() as VerletNode2D
	number_of_instances += 1
	new_node.id = number_of_instances
	new_node.position = pos
	parent.add_child(new_node)
	new_node.is_fixed = fixed
	return new_node


	
func color_debug(dd):
	var clr = lerp(Color.WHITE, Color.RED, dd * 100)
	$Sprite2D.self_modulate = clr
