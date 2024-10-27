extends Node2D


var gravity = Vector2(0,98)
var CLOTHNODE_SCENE = preload("res://Scenes/cloth_node.tscn")

func _ready():
	createNode()
	createNode($SpawnAnchor.position + Vector2.RIGHT*200)
	return
	
	
func createNode(spawnPosition = $SpawnAnchor.position):
	var newNode = CLOTHNODE_SCENE.instantiate()
	newNode.position = spawnPosition
	add_child(newNode)
