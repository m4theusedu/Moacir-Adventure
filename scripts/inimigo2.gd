extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -400.0

@onready var wall_dect := $walk_dect as RayCast2D
@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer

var direction := -1

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
		
	if wall_dect.is_colliding():
		direction *= -1
		wall_dect.scale.x *= -1
		
	if direction == 1:
		texture.flip_h = true
	else:
		texture.flip_h = false
	
	velocity.x = direction * SPEED * delta

	move_and_slide()

func _on_anim_animation_finished(anim_name: StringName):
	if anim_name == "hurt":
		queue_free()
