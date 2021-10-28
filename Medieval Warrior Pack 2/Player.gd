extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 80
const GRAVITY = 200
const JUMPHEIGHT = 200

var velocity = Vector2.ZERO

onready var animp = $AnimatedSprite/AnimationPlayer
onready var animt = $AnimatedSprite/AnimationTree
onready var anims = $AnimatedSprite
onready var swordhitbox = $hitboxpivot/SwordHitbox/collisionshape2d
onready var animationState = animt.get("parameters/playback")

enum{
	MOVE,ATTACK
}
var state = MOVE

func _ready():
	randomize()
	animt.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		if input_vector.x < 0:
			anims.flip_h = true
		else:
			anims.flip_h = false
		velocity = velocity.move_toward(input_vector *MAX_SPEED,ACCELERATION*FRICTION)
	else:
		animationState.travel("idle")
		velocity.move_toward(Vector2.ZERO,FRICTION*delta)
		
		move()
		if Input.is_action_just_pressed("attack"):
			state = ATTACK
			

func attack_state(delta):
	animationState.travel("attack")
	velocity = velocity/1.25

func move():
	velocity = move_and_slide(velocity)

func attack_animation_finished():
	state = MOVE
	velocity = Vector2.ZERO

func _process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x,MAX_SPEED,ACCELERATION*FRICTION)
		anims.flip_h = false
		if(is_on_floor()):
			animp.play("running")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED,ACCELERATION*FRICTION)
		anims.flip_h = true
		if(is_on_floor()):
			animp.play("running")
	elif Input.is_action_pressed("attack") || Input.is_action_just_pressed("attack"):
		animp.play("attack")
		swordhitbox.disabled = false
		velocity = velocity/1.25
	elif is_on_floor(): 
		velocity.x = move_toward(velocity.x, 0,FRICTION*delta)
		animp.play("idle")
		swordhitbox.disabled = true
		
	if Input.is_action_pressed("jump") && is_on_floor():
		animp.play("jump")
		velocity.y = -JUMPHEIGHT
		
	if velocity.y > 0:
		animp.play("falling")

func _physics_process(delta):
	velocity.y += GRAVITY*delta
	velocity = move_and_slide(velocity,Vector2.UP)


