extends CharacterBody2D



const SPEED = 700.0
const JUMP_VELOCITY = -400.0
@onready var wall_dect := $walk_dect as RayCast2D
var direction := -1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
		if wall_dect.is_colliding():
			direction *= -1
	
		velocity.x += direction  * SPEED * delta

	move_and_slide()
