extends KinematicBody2D

const EnemyDeathEffect = preload("res://Hit Effect/DeathEffect.tscn")

enum{
	IDLE,
	WANDER,
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
var state = CHASE

export var acceleration = 300
export var maxspeed = 50
export var friction = 200
export var wandertargetrange = 4

onready var sprite = $Bat
onready var stats = $Stats
onready var hurtbox = $hurtbox
onready var playerdetectionzone = $PlayerDetectionZone
onready var wandercontroller = $WanderController

func _ready():
	state = pick_random_state([IDLE,WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
			seek_player()
			if wandercontroller.get_time_left() == 0:
				update_wander()
		WANDER:
			seek_player()
			if wandercontroller.get_time_left() == 0:
				update_wander()
			accelerate_towards_point(wandercontroller.target_position, delta)
			if global_position.distance_to(wandercontroller.target_position) <= wandertargetrange:
				update_wander()
		CHASE:
			var player = playerdetectionzone.player
			if player != null:
				accelerate_towards_point(player.global_position,delta)
			else:state = IDLE
			
	velocity = move_and_slide(velocity)

func seek_player():
	if playerdetectionzone.can_see_player():
		state = CHASE

func update_wander():
	state = pick_random_state([IDLE,WANDER])
	wandercontroller.start_wander_timer(rand_range(1,3))

func accelerate_towards_point(point,delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * maxspeed, acceleration * delta)
	sprite.flip_h = direction.x > 0

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockbackvector * 120
	hurtbox.create_hit_effect()

func _on_Stats_nohealth():
	queue_free()
	var enemyDeathEffect  = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

