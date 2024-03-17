extends CharacterBody2D

@export var speed = 400
var direction
var score = 0

func get_input():
	direction = Input.get_axis("left","right")
	velocity.x = direction * speed
	
func _physics_process(_delta):
	# must write this line because of collision. The paddle shouldn't move downwards
	velocity.y = 0
	get_input()
	move_and_slide()
