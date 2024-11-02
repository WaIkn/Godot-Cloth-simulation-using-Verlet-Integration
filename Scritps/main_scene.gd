extends Node2D



var VERLETNODE := preload("res://Scenes/verlet_node2D.tscn")

func _ready():
	VerletNode2D.setSimulationSpace(%TopLeft.position,%BottomRight.position)
	createNode()
	
	return
	
	
func createNode(targetPosition = $SpawnAnchor.position):
	var node = VERLETNODE.instantiate()
	node.position = targetPosition
	node.NODELIST.append(node)
	add_child(node)
