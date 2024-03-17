extends CharacterBody2D

@onready var br = preload("res://Scenes/brick.tscn")
var arr
var lives = 3
var is_running = false
var game_over = false

func set_brick():
	for column in range(8):
		for row in range(5):
			var tmp_br = br.instantiate()
			tmp_br.position = Vector2(67 * (column + 1), 40 * (row + 1))
			get_node("..").add_child.call_deferred(tmp_br)
		print("test")

func _ready():
	set_velocity(Vector2(125, 250))
	set_brick()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("start"):
		is_running = true
	if lives > 0 && is_running:
		var collision_info = move_and_collide(velocity * delta)
		if collision_info:
			velocity = velocity.bounce(collision_info.get_normal())
			var collider = collision_info.get_collider().name
			# The instance names are automatically assigned like Staticbody2D@123123
			if "StaticBody2D" in collider || "Brick" in collider:
				$"../Paddle".score += 1
				velocity = velocity * 1.05
				collision_info.get_collider().queue_free()
	elif game_over:
		$"../UI/Sprite2D".show()
		$"../UI/Button".show()
		$"../UI/Button2".show()
		$"../UI/Button3".show()
		
func _on_ball_escape_body_entered(body):
	if body.name == "Ball":
		lives -= 1
		set_velocity(Vector2(randi_range(250,-250), 250))
		if velocity.x == 0:
			velocity.x = 100
		self.position = Vector2(300,240)
		is_running = false
		if lives <= 0:
			game_over = true
		print(lives)
