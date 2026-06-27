extends CharacterBody2D

# Using @export allows you to change the speed directly in the Inspector
@export var speed: float = 200.0

func _enter_tree():
	# Tells Godot who owns this specific player instance.
	set_multiplayer_authority(str(name).to_int())
	
func _ready():
	# Temporary random spawn to prevent the "Physics Pop"
	position = Vector2(randf_range(50, 200), randf_range(50, 200))
	
	# --- PHASE 2: MULTIPLAYER COLLISION GHOSTING ---
	# We set the layers mathematically using bitwise operators.
	# Layer 1 = Players, Layer 2 = Environment/Houses, Layer 3 = Flood/Obstacles
	
	collision_layer = 1 # I exist on Layer 1
	
	# I only collide with Layer 2 (value: 2) and Layer 3 (value: 4). 
	# Because I am not checking Layer 1, players will phase right through each other!
	collision_mask = 2 + 4 

func _physics_process(delta):
	# ONLY let the player who owns this instance control it.
	if not is_multiplayer_authority():
		return
		
	# Basic 2D movement
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Optional: Adding lerp makes the movement feel a bit smoother
	if input_dir != Vector2.ZERO:
		velocity = input_dir * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		
	move_and_slide()
