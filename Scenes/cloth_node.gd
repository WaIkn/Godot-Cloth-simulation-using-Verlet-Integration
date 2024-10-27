extends Node2D
class_name ClothNode


var velocity : Vector2
var previousPosition : Vector2
var forces : Vector2
var mass = 1.0


func _ready():
	velocity = Vector2.ZERO
	previousPosition = position

func _physics_process(delta):
	updateVelocity(delta)
	updatePosition(delta)

func updatePosition(delta):	
	previousPosition = position
	position += velocity * delta
	
func updateVelocity(delta):
	velocity += getAcceleration() * delta
	
func updateForces():
	forces = GlobalVars.GRAVITY
	
func getAcceleration():
	updateForces()
	return forces / mass
	
