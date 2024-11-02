extends Label



func _process(delta: float) -> void:
	text = "WIND : " + str(GlobalVars.WIND.length()).pad_decimals(2)
