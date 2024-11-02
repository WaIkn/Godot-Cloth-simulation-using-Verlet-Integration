extends Node


@export var GRAVITY = Vector2(0,980)
@export var WIND = Vector2.ZERO
@export var WIND_DIRECTION = Vector2.RIGHT
@export var WIND_AMPLITUDE = 10000.0

@onready var SUM_FORCES = GRAVITY + WIND

func _process(delta: float) -> void:
	WIND = generate_wind_force(Time.get_ticks_msec(), WIND_DIRECTION, WIND_AMPLITUDE)
	SUM_FORCES = GRAVITY + WIND
	
static func generate_wind_force(time, direction, amplitude) -> Vector2:
	var noise = FastNoiseLite.new()
	var noise_1d = noise.get_noise_1d(time / 10.0)
	return direction * abs(noise_1d) * amplitude
