extends CharacterBody2D


const SPEED = 200
const JUMP_FORCE = -350.0

# Ge
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping := true
var player_life := 1
var knockback_vetor := Vector2.ZERO
var direction


@onready var animation:=$anima as AnimatedSprite2D
@onready var remote_tranform := $remote as RemoteTransform2D

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y += gravity * delta

	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = true
	elif is_on_floor():
		is_jumping = false
		
	

	
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0: 
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if knockback_vetor != Vector2.ZERO:
		velocity = knockback_vetor
		
	_set_state()
	move_and_slide()

	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)
			
func _on_hurtbox_body_entered(_body):
	#if body.is_in_group("inimigo"):
		#queue_free()
	if player_life < 0:
		queue_free()
	else:
		if $ray_dir.is_colliding():
			take_damage(Vector2(-500, -300))
		elif $ray_esq.is_colliding():
			take_damage(Vector2(500, -300))
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_tranform.remote_path = camera_path
func take_damage(knockback_force := Vector2.ZERO, duration := 0):
	player_life -= 1
	
	if knockback_force != Vector2.ZERO:
		knockback_vetor = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vetor", Vector2.ZERO, duration)
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
func _set_state():
	var state = "player"
	
	if !is_on_floor():
		state = "jump"
	elif direction != 0:
		state = "run"
		
	if animation.name != state:
		animation.play(state)

