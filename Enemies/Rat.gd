extends KinematicBody2D

#death effect preload here

enum{
	IDLE,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var state = CHASE

export var acceleration = 300
export var maxspeed = 90
export var friction = 200
export var gravity = 300

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var hurtbox = $hurtbox
onready var playerdetectionzone = $PlayerDetectionZone

func _ready():
	pass

func _physics_process(delta):
	pass

func seek_player():
	if playerdetectionzone.can_see_player():
		state = CHASE

func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point.x)
	velocity = velocity.move_toward(direction * maxspeed, acceleration * delta)
	sprite.flip_h = direction.x > 0

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()



func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockbackvector * 120
	#hit effect
	#hurtbox.create_hit_effect()

func _on_Stats_nohealth():
	queue_free()
	var enemyDeathEffect # = EnemyDeathEffect.instance()
	#get_parent().add_child(enemyDeathEffect)
	#enemyDeathEffect.global_position = global_position
