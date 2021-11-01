extends KinematicBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 120
const GRAVITY = 400
const JUMPHEIGHT = 275

var velocity = Vector2.ZERO
var stats = PlayerStats

signal dead

onready var animp = $AnimatedSprite

onready var anims = $AnimatedSprite
onready var swordhitbox = $hitboxpivot/hitbox/collisionshape2d
onready var hitboxpivot = $hitboxpivot
onready var hurtbox = $hurtbox


func _ready():
	randomize()


func _process(delta):
	if(stats.health <= 0):
		animp.play("death")
		hurtbox.collisionshape.set_deferred("disabled",true)
		emit_signal("dead")
	else:
		if Input.is_action_pressed("ui_right") && hurtbox.moveable == true:
			velocity.x = move_toward(velocity.x,MAX_SPEED,ACCELERATION*FRICTION)
			anims.flip_h = false
			hitboxpivot.rotation_degrees =0
			if(is_on_floor()):
				animp.play("running")
		elif Input.is_action_pressed("ui_left")&& hurtbox.moveable == true:
			velocity.x = move_toward(velocity.x, -MAX_SPEED,ACCELERATION*FRICTION)
			anims.flip_h = true
			hitboxpivot.rotation_degrees =180
			if(is_on_floor()):
				animp.play("running")
		elif Input.is_action_pressed("attack") || Input.is_action_just_pressed("attack"):
			animp.play("attack")
			swordhitbox.disabled = false
			velocity.x = velocity.x/1.25
			velocity.y = velocity.y/1.25
		elif is_on_floor() && hurtbox.invincible == false: 
			velocity.x = move_toward(velocity.x, 0,FRICTION*delta)
			animp.play("idle")
			swordhitbox.disabled = true
			
		if Input.is_action_pressed("attack") || Input.is_action_just_pressed("attack"):
			animp.play("attack")
			if(animp.frame == 1 || animp.frame == 2):
				swordhitbox.disabled = false
			else:
				swordhitbox.disabled = true
			velocity = velocity/1.25
		elif Input.is_action_pressed("jump") && is_on_floor() && hurtbox.moveable == true:
			animp.play("jump")
			velocity.y = -JUMPHEIGHT
		elif velocity.y > 0 && hurtbox.invincible == false:
			animp.play("falling")

func _physics_process(delta):
	velocity.y += GRAVITY*delta
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	animp.play("hurt")
	velocity.x = 0
	velocity = move_and_slide(velocity,Vector2.UP)
	hurtbox.start_invincibility(2)


