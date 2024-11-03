extends Area2D
class_name WindArea

static func get_wind_at(x, y, delta):
	var noise = FastNoiseLite.new()
	return (1 + noise.get_noise_2d(x + Time.get_ticks_msec() * 0.01 , y + Time.get_ticks_msec() * 0.01)) * Globals.WIND_AMPLITUDE  * Globals.WIND_DIRECTION
