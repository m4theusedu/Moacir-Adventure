extends AnimatableBody2D

@onready var anim := $anim as AnimationPlayer
@onready var respaw_timer := $respaw_time as Timer
@onready var respawan_position := global_position

@export var reset_timer := 3.0

var velocity := Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered := false
# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	velocity.y += gravity * delta
	position += velocity * delta
	
func has_collided_with(_collision: KinematicCollision2D, _collider: CharacterBody2D):
	if !is_triggered:
		
		is_triggered = false
		
		velocity = Vector2.ZERO
		


func _on_anim_animation_finished(_anim_name):
	set_physics_process(true)
	respaw_timer.start(reset_timer)
	


func _on_respaw_time_timeout():
	set_physics_process(false)
	global_position = respawan_position
