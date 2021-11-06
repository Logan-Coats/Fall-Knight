extends KinematicBody2D

const PlayerDeathSound = preload("res://Medieval Warrior Pack 2/PlayerDeathSound.tscn")
const PlayerHurtSound = preload("res://Medieval Warrior Pack 2/PlayerHurtSound.tscn")
const hitsound = preload("res://Enemies/HitSound.tscn")

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 140
const GRAVITY = 400
const JUMPHEIGHT = 275

var velocity = Vector2.ZERO
var stats = PlayerStats
var step = false
signal dead
signal hitboxon

onready var animp = $AnimatedSprite
onready var footstep = $Footstep
onready var steptimer = $Footstep/steptimer
onready var anims = $AnimatedSprite
onready var swordhitbox = $hitboxpivot/hitbox/collisionshape2d
onready var hitboxpivot = $hitboxpivot
onready var hurtbox = $hurtbox


func _ready():
	#var tilemap_rect = get_parent().get_node("Fall").get_used_rect()
	#var tilemap_cell_size = get_parent().get_node("Fall").cell_size
	#$Camera2D.limit_left = tilemap_rect.position.x * tilemap_cell_size.x
	#$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell_size.x
	#$Camera2D.limit_top = tilemap_rect.position.y * tilemap_cell_size.y
	#$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell_size.y
	pass


func _process(delta):
	if(stats.health <= 0):
		animp.play("death")
		hurtbox.collisionshape.set_deferred("disabled",true)
		emit_signal("dead")
	elif hurtbox.moveable == true:
		if Input.is_action_pressed("ui_right"):
			velocity.x = move_toward(velocity.x,MAX_SPEED,ACCELERATION*FRICTION)
			anims.flip_h = false
			hitboxpivot.rotation_degrees =0
			if(is_on_floor()):
				animp.play("running")
				if step == false:
					step = true
					footstep.play()
					steptimer.start(.333)
		elif Input.is_action_pressed("ui_left"):
			velocity.x = move_toward(velocity.x, -MAX_SPEED,ACCELERATION*FRICTION)
			anims.flip_h = true
			hitboxpivot.rotation_degrees =180
			if(is_on_floor()):
				animp.play("running")
				if step == false:
					step = true
					footstep.play()
					steptimer.start(.333)
		elif (Input.is_action_pressed("attack") || Input.is_action_just_pressed("attack")):
			animp.play("attack")
			swordhitbox.disabled = false
			velocity.x = velocity.x/1.25
			velocity.y = velocity.y/1.25
		elif is_on_floor(): 
			velocity.x = move_toward(velocity.x, 0,FRICTION*delta)
			animp.play("idle")
			swordhitbox.disabled = true
		if Input.is_action_pressed("ui_right") && Input.is_action_pressed("attack"):
			animp.play("running")
		elif Input.is_action_pressed("ui_left") && Input.is_action_pressed("attack"):
			animp.play("running")
		elif (Input.is_action_pressed("attack") || Input.is_action_just_pressed("attack")):
			animp.play("attack")
			if(animp.frame == 1 || animp.frame == 2):
				swordhitbox.disabled = false
				emit_signal("hitboxon")
			else:
				swordhitbox.disabled = true
			velocity = velocity/1.25
		elif Input.is_action_pressed("jump") && is_on_floor():
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
	if stats.health == 0:
		var playerdeathsound = PlayerDeathSound.instance()
		get_tree().current_scene.add_child(playerdeathsound)
	else:
		var playerhurtsound = PlayerHurtSound.instance()
		get_tree().current_scene.add_child(playerhurtsound)

func _on_Player_hitboxon():
	var Hitsound = hitsound.instance()
	get_tree().current_scene.add_child(Hitsound)

func _on_steptimer_timeout():
	step = false
