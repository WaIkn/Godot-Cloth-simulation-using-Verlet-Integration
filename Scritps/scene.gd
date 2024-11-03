extends Node2D


func _ready():
	#Rope2D.create(%Anchor.position, self, Globals.rope_length, Globals.rope_nb_nodes)
	#Rope2D.create(%Anchor.position + Vector2.RIGHT * 50, self, Globals.rope_length, Globals.rope_nb_nodes, Vector2.DOWN)
	
	var net = Net2D.create(%Anchor.position, self, 17,17, 10, 2)
	


func _on_wind_slider_value_changed(value):
	Globals.WIND_AMPLITUDE = value
	
