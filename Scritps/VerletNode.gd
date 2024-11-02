extends Node2D
class_name VerletNode2D

@onready var previous_position = position

var damping = .999

static var MINSIMSPACE : Vector2
static var MAXSIMSPACE : Vector2
static var NODELIST = Array([VerletNode2D])


var acceleration = GlobalVars.GRAVITY

func _ready() -> void:
	NODELIST.append(self)


func _physics_process(delta: float) -> void:
	#Compute next position
	var next_position = position + (position - previous_position) * damping + acceleration * delta * delta
	#Update previous_position
	previous_position = position
	#contrain to simulation space	
	next_position = constrain(next_position)
	#Update postion
	position = next_position


func constrain(next_position : Vector2) -> Vector2:
	#constrain x
	if next_position.x < MINSIMSPACE.x:
		previous_position.x = MINSIMSPACE.x + (next_position.x - previous_position.x)
		next_position.y = MINSIMSPACE.x
		
	elif next_position.x > MAXSIMSPACE.x:
		previous_position.x = MAXSIMSPACE.x + (next_position.x - previous_position.x)
		next_position.y = MAXSIMSPACE.x
		
	#constrain y
	if next_position.y < MINSIMSPACE.y:
		previous_position.y =  MINSIMSPACE.y + (next_position.y - previous_position.y)
		next_position.y = MINSIMSPACE.y
		
	elif next_position.y > MAXSIMSPACE.y:
		previous_position.y =  MAXSIMSPACE.y + (next_position.y - previous_position.y)
		next_position.y = MAXSIMSPACE.y
	return next_position

static func setSimulationSpace(top_left : Vector2, bottom_right : Vector2) -> void:
	MINSIMSPACE = top_left
	MAXSIMSPACE = bottom_right
