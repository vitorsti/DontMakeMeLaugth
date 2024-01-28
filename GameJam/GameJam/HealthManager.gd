class_name HealthManager

extends Node

@export var health: int
@export var maxHealth: int

func _init():
	health = 0
	maxHealth = 100

func RemoveHealth(value: int):
	#print(value)
	health -= value
	if health<=0:
		health = 0
	print("Actual Health: ") 
	print(health)

func AddHealth(value: int):
	#print(value)
	health += value
	if health>=maxHealth:
		health = maxHealth
	print("Actual Health: ")
	print(health)
