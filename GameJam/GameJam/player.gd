extends RigidBody3D

@export var speed = 1200.0
var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0
var canAttack := false
@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot 

var entered_object: RigidBody3D = null
var enemyHealth: HealthManager = null
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input = Vector3.ZERO
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_forward", "move_back")
	
	apply_central_force(twist_pivot.basis * input * delta * speed)

	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x,
	deg_to_rad(-30),
	deg_to_rad(30)
	)
	
	twist_input = 0.0
	pitch_input = 0.0
	
	if Input.is_action_just_pressed("attack"):
		if entered_object != null && canAttack:
			entered_object.apply_central_impulse(Vector3(0, 1, 0))
			enemyHealth.AddHealth(1)
			
			
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * mouse_sensitivity
			pitch_input = -event.relative.y * mouse_sensitivity 
	

func _draw():
	var rotacao_atual = deg_to_rad(twist_pivot.rotation)
	var direcao = Vector2(cos(rotacao_atual), sin(rotacao_atual))
	direcao = direcao.normalized()
	var comprimento_raio = 100
	var ponto_final = twist_pivot.global_position + direcao * comprimento_raio
	#draw_line(twist_pivot.global_position, ponto_final, Color(1, 0, 0))
	#draw_line(Vector2(1.5, 1.0), Vector2(1.5, 4.0), Color.GREEN, 1.0)

func _on_hit_box_area_entered(area):
	entered_object = area.get_parent()
	enemyHealth = area.getHealth()
	print(enemyHealth.health)
	canAttack = true
	pass # Replace with function body.


func _on_hit_box_area_exited(area):
	area.setCoolDown(true)
	entered_object = null
	enemyHealth = null
	canAttack = false
	pass # Replace with function body.
