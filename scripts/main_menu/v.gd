extends Node3D


var x_noise
var y_noise

var target_rot : Vector3
var noise_rot : Vector3
var noise_count = 0

@export var noise_amp : float = 5
@export var noise_freq : float = 25


func _ready():
	x_noise = FastNoiseLite.new()
	y_noise = FastNoiseLite.new()
	
	x_noise.seed = 10
	x_noise.fractal_octaves = 1
	
	y_noise.seed = 11
	y_noise.fractal_octaves = 1


func _process(delta):
	noise_count += noise_freq * delta
	noise_rot.x = x_noise.get_noise_1d(noise_count) * noise_amp
	noise_rot.y = y_noise.get_noise_1d(noise_count) * noise_amp
	
	rotation_degrees = noise_rot
