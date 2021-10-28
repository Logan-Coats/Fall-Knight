extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 80
const GRAVITY = 200
const JUMPHEIGHT = 200

var velocity = Vector2.ZERO

onready var animp = $AnimatedSprite
onready var swordhitbox = $hitboxpivot/SwordHitbox/collisionshape2d


func _ready():
	randomize()

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = move_toward(velocity.x,MAX_SPEED,ACCELERATION*FRICTION)
		animp.play("run") #change to animated sprite because have to flip left & right
	elif Input.is_action_pressed("ui_left"):
		velocity.x = move_toward(velocity.x, -MAX_SPEED,ACCELERATION*FRICTION)
		animp.play("run")
	else: 
		velocity.x = move_toward(velocity.x, 0,FRICTION*delta)
		animp.play("idle")
		
	if Input.is_action_pressed("attack"):
		animp.play("attack")
		swordhitbox.disabled = false
	
	if Input.is_action_pressed("jump") && is_on_floor():
		velocity.y = -JUMPHEIGHT
		animp.play("jump")
	if velocity.y > 0:
		animp.play("falling")

func _physics_process(delta):
	velocity.y += GRAVITY*delta
	velocity = move_and_slide(velocity,Vector2.UP)


