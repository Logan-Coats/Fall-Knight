extends KinematicBody2D

const EnemyDeathEffect = preload("res://Hit Effect/DeathEffect.tscn")
const EnemyDeathSound = preload("res://Enemies/EnemyDeathSound.tscn")
const heart = preload("res://Heart.tscn")

enum{
	IDLE,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var state = CHASE
var dropchance
const mindropchance = 75

export var acceleration = 300
export var maxspeed = 90
export var friction = 200
export var gravity = 1000

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var hurtbox = $hurtbox
onready var playerdetectionzone = $PlayerDetectionZone

func _ready():
	randomize()
	dropchance = randi() %100

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = Vector2.ZERO
			velocity.move_toward(Vector2.ZERO, friction * delta)
			sprite.stop()
			seek_player()
		CHASE:
			sprite.play("default")
			var player = playerdetectionzone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity, Vector2.DOWN)

func seek_player():
	if playerdetectionzone.can_see_player():
		state = CHASE

func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * maxspeed, acceleration * delta)
	sprite.flip_h = direction.x > 0


func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockbackvector * 120
	hurtbox.create_hit_effect()

func _on_Stats_nohealth():
	queue_free()
	if dropchance > mindropchance:
		var Heart = heart.instance()
		get_tree().current_scene.add_child(Heart)
		Heart.global_position = global_position
	var enemydeathsound = EnemyDeathSound.instance()
	get_tree().current_scene.add_child(enemydeathsound)
	var enemyDeathEffect  = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position


func _on_PlayerDetectionZone_body_exited(body):
	sprite.frame = 0
	velocity = velocity.move_toward(Vector2.ZERO, acceleration*friction)
