extends Node2D
class_name VerletNode2D


@onready var previous_position = position

var damping = .98
var mass = 100

static var MINSIMSPACE : Vector2
static var MAXSIMSPACE : Vector2
static var NODELIST = Array()


static var SCENE := preload("res://Scenes/verlet_node2D.tscn")

var connections = Array()


var acceleration : Vector2
var fixed = false

var max_velocity = 1000.0

func _ready() -> void:
	NODELIST.append(self)
	
	update_acceleration(GlobalVars.SUM_FORCES)

func _physics_process(delta: float) -> void:
	update_acceleration(GlobalVars.SUM_FORCES)
	#Compute next position
	var next_position = position + (position - previous_position) * damping + acceleration * delta * delta
	#Update previous_position
	previous_position = position
	#contrain to simulation space	
	next_position = constrain(next_position)
	#Update postion
	position = next_position

func update_acceleration(forces):
	acceleration = forces / mass
	

func constrain(next_position : Vector2, simulation_space = false) -> Vector2:
	if fixed:
		next_position = position
		
	if !simulation_space:
		return next_position
	#constrain x
	if next_position.x < MINSIMSPACE.x:
		previous_position.x = MINSIMSPACE.x + (next_position.x - previous_position.x)
		next_position.x = MINSIMSPACE.x
		
	elif next_position.x > MAXSIMSPACE.x:
		previous_position.x = MAXSIMSPACE.x + (next_position.x - previous_position.x)
		next_position.x = MAXSIMSPACE.x
		
	#constrain y
	if next_position.y < MINSIMSPACE.y:
		previous_position.y =  MINSIMSPACE.y + (next_position.y - previous_position.y)
		next_position.y = MINSIMSPACE.y
		
	elif next_position.y > MAXSIMSPACE.y:
		previous_position.y =  MAXSIMSPACE.y + (next_position.y - previous_position.y)
		next_position.y = MAXSIMSPACE.y
	

	return next_position

func connect_with(target : VerletNode2D):
	var link = Array()
	link.append(self)
	link.append(target)
	connections.append(link)
	

static func setSimulationSpace(top_left : Vector2, bottom_right : Vector2) -> void:
	MINSIMSPACE = top_left
	MAXSIMSPACE = bottom_right
