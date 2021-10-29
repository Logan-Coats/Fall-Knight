extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 80
const GRAVITY = 200
const JUMPHEIGHT = 200

var velocity = Vector2.ZERO

onready var animp = $AnimatedSprite

onready var anims = $AnimatedSprite
onready var swordhitbox = $hitboxpivot/SwordHitbox/collisionshape2d
onready var hitboxpivot = $hitboxpivot



func _ready():
	randomize()


func _process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x,MAX_SPEED,ACCELERATION*FRICTION)
		anims.flip_h = false
		hitboxpivot.rotation_degrees =0
		if(is_on_floor()):
			animp.play("running")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED,ACCELERATION*FRICTION)
		anims.flip_h = true
		hitboxpivot.rotation_degrees =180
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
		
	if Input.is_action_pressed("attack") || Input.is_action_just_pressed("attack"):
		animp.play("attack")
		swordhitbox.disabled = false
		velocity = velocity/1.25
	elif Input.is_action_pressed("jump") && is_on_floor():
		animp.play("jump")
		velocity.y = -JUMPHEIGHT
	elif velocity.y > 0:
		animp.play("falling")

func _physics_process(delta):
	velocity.y += GRAVITY*delta
	velocity = move_and_slide(velocity,Vector2.UP)


