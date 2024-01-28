extends RigidBody3D

@export var hp = 10

#func _on_hurt_box_area_entered(hitbox):
	#var base_damage = hitbox.base_damage
	#self.hp -= base_damage
	#print(hitbox.get_parent().name + "'s hitbox touched " + name + "'s hitbox and dealt" + str(base_damage))
