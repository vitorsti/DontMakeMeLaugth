extends Area3D

var myHealth = HealthManager.new()
var timer: float = 0.0
var healthRegenCooldown: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	CoolDown()
	#m
	pass

func _on_area_entered(area):
	pass

func getHealth() -> HealthManager:
	#print(myHealth.health)
	return myHealth
	
func setCoolDown(value:bool):
	healthRegenCooldown = value

func CoolDown():
	if healthRegenCooldown:
		timer+=0.1
		if timer>=2.0:
			timer=0.0
			myHealth.RemoveHealth(1)
			if myHealth.health <= 0:
				healthRegenCooldown = false
