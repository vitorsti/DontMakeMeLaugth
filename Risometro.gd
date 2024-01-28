extends Sprite3D

var risos = 0.0


@onready var pointer := $PointerFather

@export var downvalue = 0.001

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		risos -= 1.0
		risos = clamp(risos, -180.0, 0.0)  # Ensure risos stays within the range of 0 to 180
		

	pointer.rotation_degrees.z = risos
