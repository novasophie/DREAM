extends CharacterBody2D

@export var speed: float = 200.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# 1. Get 2D input vector (x: -1 to 1, y: -1 to 1)
	var input_vector := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# 2. Apply movement physics
	if input_vector != Vector2.ZERO:
		velocity = input_vector * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	move_and_slide()

	# 3. Handle animations based on movement direction
	# Prioritize horizontal movement if moving diagonally
	if abs(input_vector.x) >= abs(input_vector.y) and input_vector.x != 0:
		if input_vector.x < 0:
			animated_sprite.play("walk_left")
		else:
			animated_sprite.play("default") # Right animation
	elif input_vector.y != 0:
		if input_vector.y < 0:
			animated_sprite.play("walk_up")
		else:
			animated_sprite.play("walk_down")